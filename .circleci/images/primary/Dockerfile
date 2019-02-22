# Setup the stack toolset
FROM fpco/stack-build:latest
MAINTAINER Eric Kalosa-Kenyon <helloateric@gmail.com>

RUN apt-get update
RUN apt-get install -y git ssh tar gzip ca-certificates
RUN apt-get autoremove && apt-get clean

# Setup Python 3.4 for the "cpython" tools
WORKDIR /usr/local/src
RUN wget https://www.python.org/ftp/python/3.4.9/Python-3.4.9.tgz
RUN tar -xvf Python-3.4.9.tgz
WORKDIR /usr/local/src/Python-3.4.9
RUN ./configure
RUN make -j8
RUN make install

# Copy sourcefiles into container and install
RUN mkdir /app
WORKDIR /app
