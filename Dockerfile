FROM fedora:27

ARG GITHUB_TOKEN
ARG GITHUB_USER=SkYNewZ
ARG GITHUB_REPO=Boostnote-packages

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
RUN cd /root/Boostnote/dist/ && \
    tar -zcvf Boostnote-linux-x64.tar.gz Boostnote-linux-x64 && \
    rm -rf /root/Boostnote/dist/Boostnote-linux-x64 && \
    ls -l /root/Boostnote/dist


# install github-release
RUN dnf install -y golang && \
    go get github.com/aktau/github-release

# publish release
RUN cd /root/Boostnote && \
    export LAST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`) && \
    /root/go/bin/github-release release \
    --user $GITHUB_USER \
    --repo $GITHUB_REPO \
    --tag $LAST_TAG \
    --name $LAST_TAG \
    --description "Boostnote package version ${LAST_TAG}" && \
    /root/go/bin/github-release upload \
    --user $GITHUB_USER \
    --repo $GITHUB_REPO \
    --tag $LAST_TAG \
    --name "Boostnote-linux-x64-${LAST_TAG}.tar.gz" \
    --file /root/Boostnote/dist/Boostnote-linux-x64.tar.gz && \
    /root/go/bin/github-release upload \
    --user $GITHUB_USER \
    --repo $GITHUB_REPO \
    --tag $LAST_TAG \
    --name $(ls /root/Boostnote/dist/ | grep '.rpm') \
    --file /root/Boostnote/dist/$(ls /root/Boostnote/dist/ | grep '.rpm') && \
    /root/go/bin/github-release upload \
    --user $GITHUB_USER \
    --repo $GITHUB_REPO \
    --tag $LAST_TAG \
    --name $(ls /root/Boostnote/dist/ | grep '.deb') \
    --file /root/Boostnote/dist/$(ls /root/Boostnote/dist/ | grep '.deb')
