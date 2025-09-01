#!/bin/bash -e
TOOLCHAIN_TAR="/root/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar.xz"
SYSROOT_TAR="/root/SDK_usr_tg5040_a133p.tgz"
SDL2_TAR="/root/SDL2-2.30.8.tar.gz"
CMAKE41_TAR="/root/cmake-4.1.0.tar.gz"

cd /opt
tar xf "${TOOLCHAIN_TAR}"



cd gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu
mkdir sysroot
cd sysroot
cp -a ../aarch64-none-linux-gnu/libc/* .
tar xf "${SYSROOT_TAR}"

cd /opt
tar xf "${CMAKE41_TAR}"
cd cmake-4.1.0
./bootstrap --prefix=/usr        \
            --system-libs        \
            --mandir=/share/man  \
            --no-system-jsoncpp  \
            --no-system-cppdap   \
            --no-system-librhash \
            --docdir=/share/doc/cmake-4.1.0 \
            --parallel="$(nproc)" &&
            make -j"$(nproc)" && make install

cd /opt 
tar xf "${SDL2_TAR}"
#mv /root/sdl2-config.cmake /opt/SDL2-2.26.1

mv /root/toolchain.cmake /opt
cd /opt/SDL2-2.30.8
cp /opt/toolchain.cmake .

mkdir build && cd build
cmake -DCMAKE_TOOLCHAIN_FILE=/opt/toolchain.cmake .. && make -j"$(nproc)" && make install

cd /opt
python3 -m pip install meson --upgrade

rm -f "${TOOLCHAIN_TAR}" "${SYSROOT_TAR}" "${SDL2_TAR}" "${CMAKE41_TAR}"
