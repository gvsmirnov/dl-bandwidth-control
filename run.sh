#!/usr/bin/env sh

run_experiment() {
    EXPERIMENT=$1

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

echo '' > .env
docker-compose build > /dev/null || { echo 'Failed to build images, run `docker-compose build` for debug'; exit 1; }

for f in client/tc/*.sh; do
    run_experiment $(basename $f .sh)
done

