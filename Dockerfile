FROM centos:6.8
MAINTAINER scottw

WORKDIR /build

RUN yum -y update \
    && yum -y upgrade \
    && yum -y install gcc openssl-devel \
    && yum clean all \
    && rm /etc/ld.so.cache \
    && rm -rf /{root,tmp,var/cache/{ldconfig,yum}}/* \
    \
    && curl -SLO https://cpan.metacpan.org/authors/id/S/SH/SHAY/perl-5.24.1.tar.bz2 \
    && echo 'd43ac3d39686462f86eed35b3c298ace74f1ffa0 *perl-5.24.1.tar.bz2' | sha1sum -c - \
    && mkdir perl-build \
    && tar --strip-components=1 -xjf perl-5.24.1.tar.bz2 -C perl-build \
    && cd perl-build \
    && ./Configure -des \
                   -Duse64bitall \
                   -Duselargefiles \
    && make \
    && make test_harness \
    && make install \
    \
    && curl -LO https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm \
    && chmod +x cpanm \
    && ./cpanm App::cpanminus \
    && cd / \
    && rm -rf /build

WORKDIR /
CMD ["/bin/bash"]
