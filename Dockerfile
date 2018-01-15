FROM fedora:27

WORKDIR /root

# install system
RUN dnf install -y dpkg dpkg-dev rpm-build fakeroot git nodejs && \
    node -v && npm -v && \
    npm install -g grunt

# install Boostnote
RUN git clone https://github.com/BoostIO/Boostnote && \
    cd Boostnote && \
    npm install

# build packages
RUN cd Boostnote && \
    grunt build

# compact
RUN tar -zcvf /root/Boostnote/dist/Boostnote-linux-x64.tar.gz /root/Boostnote/dist/Boostnote-linux-x64 && \
    rm -rf /root/Boostnote/dist/Boostnote-linux-x64 && \
    ls -l /root/Boostnote/dist

# publish release
RUN dnf install -y golang && \
    go get github.com/aktau/github-release && \
    cd /root/Boostnote && \
    export LAST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`) && \
    github-release release \
    --user SkYNewZ \
    --repo Boostnote-packages \
    --tag $LAST_TAG \
    --name "Boostnote package version ${LAST_TAG}" \
    --pre-release
