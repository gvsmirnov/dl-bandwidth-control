FROM alpine

RUN apk add --no-cache iperf3
ADD run.sh /
RUN chmod +x run.sh

ENTRYPOINT ["/run.sh"]

# iperf3 default
EXPOSE 5201
