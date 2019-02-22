# FROM python:3.4.9-stretch AS build
# RUN which python3
# RUN python3 --version

FROM fpco/stack-build:latest
MAINTAINER Eric Kalosa-Kenyon <helloateric@gmail.com>

RUN apt-get update
RUN apt-get install -y git ssh tar gzip ca-certificates
# RUN add-apt-repository -y ppa:deadsnakes/ppa
# RUN apt-get install -y python3.4
# RUN apt-get install -y python3.4 python3.4-dev
RUN apt-get autoremove && apt-get clean

# Install python3.4
WORKDIR /usr/local/src
RUN wget https://www.python.org/ftp/python/3.4.9/Python-3.4.9.tgz
RUN tar -xvf Python-3.4.9.tgz
WORKDIR /usr/local/src/Python-3.4.9
RUN ./configure
RUN make -j8
RUN make install

# COPY --from=build /usr/local/bin/python3 /usr/local/bin/python3
# RUN /usr/local/bin/python3 --version

# RUN ls /
# CD
# RUN wget https://www.python.org/ftp/python/3.4.9/Python-3.4.9.tgz -P /usr/src
