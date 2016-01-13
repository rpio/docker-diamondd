FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
# Set timezone
RUN echo "Asia/Singapore" > /etc/timezone \
 && dpkg-reconfigure -f noninteractive tzdata

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y git yasm curl zip \
    make g++ python-dev net-tools ca-certificates build-essential libboost-all-dev libssl-dev \
    libcurl4-openssl-dev libdb-dev libdb++-dev libgmp-dev libminiupnpc-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV HOME /diamond
RUN useradd -s /bin/bash -m -d /diamond diamond
RUN chown diamond:diamond -R /diamond

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

USER diamond
VOLUME ["/diamond"]

RUN git clone https://github.com/DMDcoin/diamond.git ./app && mkdir -p ./app/src/obj
WORKDIR ./app/src
RUN make -f makefile.unix USE_UPNP=- -e PIE=1 && sudo cp diamondd /usr/local/bin && cd ../../ && rm -rf ./app

EXPOSE 17771 17772
CMD ["dmd_oneshot"]



#WORKDIR /
#ADD dmd/ /data/dmd/
#ADD staking.sh /
#RUN chmod 700 /data/dmd
#RUN mkdir app
#RUN git clone https://github.com/DMDcoin/diamond.git /app && mkdir -p /app/src/obj

#WORKDIR /app/src

#RUN make -f makefile.unix USE_UPNP=1 -e PIE=1 && cp diamondd /usr/local/bin  && echo "Build complete."
#WORKDIR /data/dmd
#VOLUME ["/data/dmd"]



#CMD ["/usr/bin/sh", "staking.sh"]
# RUN chmod +x /usr/local/bin/diamondd && rm -rf /app
