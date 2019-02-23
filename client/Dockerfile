FROM alpine

RUN apk add --no-cache iperf3 iproute2
WORKDIR /client

ADD run.sh .
ADD tc tc/
RUN chmod -R +x .

ENV SERVER=server
ENV PORT=5201
ENV EXPERIMENT=baseline

ENTRYPOINT ["./run.sh"]

