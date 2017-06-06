FROM debian:jessie-slim

RUN apt-get update && apt-get install -y wget

RUN wget -P /etc/apt/sources.list.d https://sslmate.com/apt/jessie/sslmate.list
RUN wget -P /etc/apt/trusted.gpg.d https://sslmate.com/apt/jessie/sslmate.gpg
RUN apt-get update \
    && apt-get install -y -q --no-install-recommends \
    sslmate \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/* /
RUN chmod a+x /start.sh

ADD https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 /bin/gosu
RUN chmod a+x /bin/gosu

COPY bin/k8s-sslmate /bin/
RUN chmod a+x /bin/k8s-sslmate

ENTRYPOINT ["/start.sh"]
