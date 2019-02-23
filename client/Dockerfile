FROM alpine

RUN apk add --no-cache iperf3
ADD run.sh /
RUN chmod +x run.sh

ENTRYPOINT ["/run.sh"]
