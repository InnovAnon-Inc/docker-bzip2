FROM innovanon/doom-base as bzip2
ARG LFS=/mnt/lfs
USER lfs
 #&& TSOCKS_PASSWORD=abc123 tsocks wget -O bzip2.tgz                                          \
RUN sleep 31 \
 && command -v strip.sh                 \
 && curl --proxy $SOCKS_PROXY -o bzip2.tgz -L             \
  https://sourceforge.net/projects/bzip2/files/latest/download \
 && tar xf  bzip2.tgz                                          \
 && cd      bzip2-*                                            \
 && make                                                       \
 && make PREFIX=/tmp/bzip2/usr/local install -n                \
 && make PREFIX=/tmp/bzip2/usr/local install                   \
 && cd          /tmp/bzip2                                     \
 && strip.sh .                                                 \
 && tar acf       ../bzip2.txz .                               \
 && rm -rf $LFS/sources/bzip2*
# TODO
#      CPPFLAGS="$CPPFLAGS"                     \
#      CXXFLAGS="$CXXFLAGS"                     \
#      CFLAGS="$CFLAGS"                         \
#      LDFLAGS="$LDFLAGS"                       \
#      CC="$CC"                                 \
#      CXX="$CXX"                               \
#      FC="$FC"                                 \
#      PATH="$PATH"                             \
#      LIBRARY_PATH="$LIBRARY_PATH"             \
#      LD_LIBRARY_PATH="$LD_LIBRARY_PATH"       \
#      CPATH="$CPATH"                           \
#      C_INCLUDE_PATH="$C_INCLUDE_PATH"         \
#      CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH" \
#      OBJC_INCLUDE_PATH="$OBJC_INCLUDE_PATH"   \
#      LD_RUN_PATH="$LD_RUN_PATH"               \

#FROM innovanon/doom-base as test
#COPY --from=bzip2 /tmp/bzip2.txz /tmp/
#RUN tar vxf       /tmp/bzip2.txz \
# && ldd           /tmp/bzip2/usr/local/lib/libzip2.so

FROM scratch as final
COPY --from=bzip2 /tmp/bzip2.txz /tmp/

