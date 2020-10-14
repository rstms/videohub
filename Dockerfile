FROM debian:buster

RUN apt update && apt-get install -y \
  build-essential \
  libpcre3 \
  libpcre3-dev \
  libssl-dev \
  zlib1g-dev \
  wget \
  unzip \
  figlet


RUN \
  wget http://nginx.org/download/nginx-1.15.1.tar.gz && \
  tar zxfv nginx-1.15.1.tar.gz

RUN \
  wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/dev.zip && \
  unzip dev.zip

RUN \
  cd nginx-1.15.1 &&\
  ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-dev && \
  make && \
  make install

COPY rtmp.conf .
RUN cat rtmp.conf >> /usr/local/nginx/conf/nginx.conf

COPY entrypoint.sh /

CMD /entrypoint.sh
