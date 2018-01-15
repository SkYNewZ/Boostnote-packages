FROM fedora:27 as builder

WORKDIR /root

# install system
RUN dnf install -y dpkg dpkg-dev rpm-build fakeroot git nodejs && \
    node -v && npm -v && \
    npm install -g grunt

# install Boostnote
RUN git clone https://github.com/BoostIO/Boostnote --single-branch --depth=1 && \
    cd Boostnote && \
    npm install

# build packages
RUN cd Boostnote && \
    grunt build

# compact
RUN tar -zcvf /root/Boostnote/dist/Boostnote-linux-x64.tar.gz /root/Boostnote/dist/Boostnote-linux-x64 && \
    rm -rf /root/Boostnote/dist/Boostnote-linux-x64 && \
    ls -l /root/Boostnote/dist


FROM alpine:latest
RUN mkdir /app
WORKDIR /app

# get Boostnote Package
COPY --from=builder /root/Boostnote/dist/* /app/

# map this volume to get packages
VOLUME /app
ENTRYPOINT ["ls", "-l", "/app"]
