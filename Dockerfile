FROM fedora:38

ENV TZ America/New_York

ENV GCC_VERSION 12.3.0
ENV GCC_VERSION_SHORT 12.3

ENV MAKE_JOBS 8

RUN dnf update -y \
    && dnf install -y @development-tools \
    && dnf install -y mpfr-devel gmp-devel libmpc-devel zlib-devel \
          glibc-devel.i686 glibc-devel isl-devel g++ gcc-gnat gcc-gdc \
          libgphobos-static make diffutils \
          wget xz ruby-devel fedora-packager rpmdevtools

ADD ./build.sh /build.sh

CMD [ "build.sh" ]
