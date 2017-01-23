FROM abaez/lua:5.1

LABEL maintainer "Alejandro Baez https://twitter.com/a_baez"

ENV LUAROCKS_VERSION 2.4.2
ENV LUAROCKS_INSTALL luarocks-$LUAROCKS_VERSION
ENV TMP_LOC /tmp/luarocks

# Build Luarocks
RUN curl -OL \
  https://luarocks.org/releases/${LUAROCKS_INSTALL}.tar.gz

RUN tar xvf $LUAROCKS_INSTALL.tar.gz  && \
  rm $LUAROCKS_INSTALL.tar.gz && \
  mv $LUAROCKS_INSTALL $TMP_LOC

WORKDIR $TMP_LOC

RUN ./configure \
  --with-lua=$WITH_LUA \
  --with-lua-include=$LUA_INCLUDE \
  --with-lua-lib=$LUA_LIB

RUN make build

RUN make install

WORKDIR /

RUN rm $TMP_LOC -rf

