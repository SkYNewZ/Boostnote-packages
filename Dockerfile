FROM fedora:27

ARG GITHUB_TOKEN
ARG GITHUB_USER=SkYNewZ
ARG GITHUB_REPO=Boostnote-packages

WORKDIR /root

# install system
RUN dnf install -y \
    dpkg \
    dpkg-dev \
    rpm-build \
    fakeroot \
    git \
    nodejs \
    golang && \
    go get github.com/aktau/github-release && \
    npm install -g grunt && \
    node -v && npm -v

# install Boostnote
RUN git clone https://github.com/BoostIO/Boostnote
WORKDIR /root/Boostnote

#înstall Boostnote dependencies
RUN npm install

# build packages rpm and deb
RUN grunt build

# compact standalone package
RUN cd /root/Boostnote/dist/ && \
    tar -zcvf Boostnote-linux-x64.tar.gz Boostnote-linux-x64 && \
    rm -rf /root/Boostnote/dist/Boostnote-linux-x64

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
    --name "Boostnote Standalone package" \
    --file /root/Boostnote/dist/Boostnote-linux-x64.tar.gz && \
    /root/go/bin/github-release upload \
    --user $GITHUB_USER \
    --repo $GITHUB_REPO \
    --tag $LAST_TAG \
    --name "Fedora/Redhat RPM package" \
    --file /root/Boostnote/dist/$(ls /root/Boostnote/dist/ | grep '.rpm') && \
    /root/go/bin/github-release upload \
    --user $GITHUB_USER \
    --repo $GITHUB_REPO \
    --tag $LAST_TAG \
    --name "Debian/Ubuntu installer" \
    --file /root/Boostnote/dist/$(ls /root/Boostnote/dist/ | grep '.deb')
