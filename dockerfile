FROM ubuntu
RUN  export DEBIAN_FRONTEND=noninteractive && apt-get -qq update && apt-get -qq install nginx
