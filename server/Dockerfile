FROM alpine

RUN apk add --no-cache iperf3

WORKDIR /server
ADD run.sh .
RUN chmod +x run.sh

# iperf3 default
EXPOSE 5201

ENTRYPOINT ["./run.sh"]

