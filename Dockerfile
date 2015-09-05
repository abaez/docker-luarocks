FROM abaez/lua:5.1

MAINTAINER [Alejandro Baez](https://twitter.com/a_baez)

ENV LUAROCKS_VERSION 2.2.2
ENV LUAROCKS_INSTALL luarocks-$LUAROCKS_VERSION
ENV TMP_LOC /opt/luarocks

# Build Luarocks
RUN curl -O http://keplerproject.github.io/luarocks/releases/luarocks-$LUAROCKS_VERSION.tar.gz

RUN tar xvf $LUAROCKS_INSTALL.tar.gz  && \
  rm $LUAROCKS_INSTALL.tar.gz && \
  mv $LUAROCKS_INSTALL $TMP_LOC

WORKDIR $TMP_LOC

RUN ./configure \
  --lua-version=$LUA_MAJOR_VERSION \
  --prefix=/usr/local \
  --with-lua=/usr/local

RUN make build

RUN make install

WORKDIR /

RUN rm $TMP_LOC -rf

