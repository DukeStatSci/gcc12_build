#!/bin/sh

wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz \
&& tar -xf gcc-${GCC_VERSION}.tar.xz

mkdir /gcc-${GCC_VERSION}/build \
&& mkdir /gcc-install

cd gcc-${GCC_VERSION}/build \
&& ../configure --enable-bootstrap \
    --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,lto \
    --prefix=/usr \
    --program-suffix=-${GCC_VERSION_SHORT} \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info --enable-shared --enable-threads=posix \
    --enable-checking=release --enable-multilib --with-system-zlib \
    --enable-__cxa_atexit --disable-libunwind-exceptions \
    --enable-gnu-unique-object --enable-linker-build-id \
    --with-gcc-major-version-only --enable-libstdcxx-backtrace \
    --with-libstdcxx-zoneinfo=/usr/share/zoneinfo --with-linker-hash-style=gnu \
    --enable-plugin --enable-initfini-array --with-isl \
    --enable-offload-targets=nvptx-none --enable-offload-defaulted \
    --enable-gnu-indirect-function --enable-cet --with-tune=generic \
    --with-arch_32=i686 --build=x86_64-redhat-linux \
    --with-build-config=bootstrap-lto --enable-link-serialization=1 \
    --with-default-libstdcxx-abi=new --with-build-config=bootstrap-lto \
&& make -j${MAKE_JOBS} \
&& make DESTDIR=/gcc-install install


fpm -s dir -t rpm -C /gcc-install/ --name gcc${GCC_VERSION_SHORT} \
    --version ${GCC_VERSION} --iteration 1 --description "gcc v${GCC_VERSION}" .

mv *.rpm /out/
