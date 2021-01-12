FROM innovanon/doom-base as bzip2
ARG LFS=/mnt/lfs
USER lfs
 #&& TSOCKS_PASSWORD=abc123 tsocks wget -O bzip2.tgz                                          \
RUN sleep 31 \
 && curl --proxy $SOCKS_PROXY -o bzip2.tgz                \
  https://sourceforge.net/projects/bzip2/files/latest/download \
 && tar xf  bzip2.tgz                                          \
 && cd      bzip2-*                                            \
 && make                                                       \
 && make PREFIX=/tmp/bzip2/usr/local install -n                \
 && make PREFIX=/tmp/bzip2/usr/local install                   \
 && cd          /tmp/bzip2                                     \
 && tar acf       ../bzip2.txz .                               \
 && rm -rf $LFS/sources/bzip2*

#FROM innovanon/doom-base as test
#COPY --from=bzip2 /tmp/bzip2.txz /tmp/
#RUN tar vxf       /tmp/bzip2.txz \
# && ldd           /tmp/bzip2/usr/local/lib/libzip2.so

FROM scratch as final
COPY --from=bzip2 /tmp/bzip2.txz /tmp/

