#!/usr/bin/env bash

run_experiment() {
    EXPERIMENT=$1

    if [ ! -f "client/tc/$EXPERIMENT.sh" ]; then
        echo "Error: experiment '$EXPERIMENT' not found. Available experiments: "
        ls client/tc | sed 's/.sh//' | sed 's/^/ - /'
        exit 0
    fi

    echo '==============================================================================='
    echo " Running experiment: $EXPERIMENT"
    echo '==============================================================================='

    echo "EXPERIMENT=$EXPERIMENT" > .env

    docker-compose up --abort-on-container-exit > /dev/null 2>/dev/null \
        || { echo 'Failed to run experiment'; docker-compose logs; exit 1; }

    docker-compose logs --no-color client | grep 'sender\|receiver' | tail -2 | sed 's/[^|]*|//' # print only the summary, stripping container name (looks like 'client_1  | ')
    docker-compose down -v --remove-orphans > /dev/null 2>/dev/null

    rm .env
}

# If there are no command line arguments, or a single argument with the value "all", then run all the experiments found in client/tc.
# Otherwise, try to run an experiment for each name passed as a command line argument, for example:
#
#  ./run.sh # will run all the experiments
#  ./run.sh all # will run all the experiments
#  ./run.sh baseline # will run only the 'baseline' experiment
#  ./run.sh baseline naive # will run only the 'baseline' and 'naive' experiments

EXPERIMENTS=()

argc=$#
argv=("$@")

if [ "$argc" -eq "0" ] || { [ "$argc" -eq "1" ] && [ "${argv[0]}" == "all" ]; }; then
    for f in client/tc/*.sh; do
        EXPERIMENTS+=("$(basename $f .sh)")
    done
else
    EXPERIMENTS=("${argv[@]}")
fi

# docker-compose build verifies that the `env_file` is present, so give it a blank one.
echo '' > .env
docker-compose build > /dev/null || { echo 'Failed to build images, run `docker-compose build` for debug'; exit 1; }

for e in "${EXPERIMENTS[@]}"; do
    run_experiment "$e"
done

