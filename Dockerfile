FROM debian:bullseye-slim
ENV DEBIAN_FRONTEND noninteractive

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && apt-get -y install \
	bc \
	build-essential \
	bzip2 \
	bzr \
	cmake \
	cmake-curses-gui \
	cpio \
	git \
	libncurses5-dev \
	make \
	rsync \
	scons \
	tree \
	unzip \
	wget \
	zip \
    curl \
    libuv1-dev \
    libarchive-dev \
    nghttp2 \
    libexpat-dev \
    zlib1g-dev \
    libcurl4-openssl-dev \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/workspace
WORKDIR /root

COPY support .
RUN ./setup-toolchain.sh
RUN cat setup-env.sh >> .bashrc
RUN rm -f setup-toolchain.sh

VOLUME /root/workspace
WORKDIR /root/workspace

CMD ["/bin/bash"]
