# Boostnote-packages
[![Build Status](https://travis-ci.org/BoostIO/Boostnote.svg?branch=v0.8.20)](https://travis-ci.org/BoostIO/Boostnote)
[![CircleCI](https://circleci.com/gh/SkYNewZ/Boostnote-packages.svg?style=svg)](https://circleci.com/gh/SkYNewZ/Boostnote-packages)
[![Github All Releases](https://img.shields.io/github/downloads/SkYNewZ/Boostnote-packages/total.svg)](https://github.com/SkYNewZ/Boostnote-packages/releases)

Please check Boostnote repository before : https://github.com/BoostIO/Boostnote/

I follow [this guide](https://github.com/BoostIO/Boostnote/blob/master/docs/build.md).
Packages are now builed by [CircleCI](https://circleci.com/gh/SkYNewZ/Boostnote-packages).

## How it works
According to [this guide](https://github.com/BoostIO/Boostnote/blob/master/docs/build.md),
* Install dependencies for building : `dnf install -y dpkg dpkg-dev rpm-build fakeroot`
* Clone the Boostnote repo and install node dependencies
* Launch build command to generate .rpm and .deb package ([see here](https://github.com/BoostIO/Boostnote/blob/master/docs/build.md#make-own-distribution-packages-deb-rpm))
* Tar the standalone package
* Use github-release for automatic publishing (https://github.com/aktau/github-release)
  * Create new tag
  * Upload `Boostnote-linux-x64-${LAST_TAG}.tar.gz`
  * Upload `boostnote_0.8.20_amd64.deb`
  * Upload `boostnote-0.8.20.x86_64.rpm`

## Downloads and install
### Fedora/Redhat
```sh
# install require package
$ sudo yum install lsb
# download
$ wget https://github.com/SkYNewZ/Boostnote-packages/releases/download/v0.8.20/boostnote-0.8.20.x86_64.rpm -O /tmp/boostnote-0.8.20.x86_64.rpm
# install
$ sudo rpm -ivh /tmp/boostnote-0.8.20.x86_64.rpm
# clean
$ rm /tmp/boostnote-0.8.20.x86_64.rpm
```

### Debian/Ubuntu
```bash
# download
$ wget hhttps://github.com/SkYNewZ/Boostnote-packages/releases/download/v0.8.20/boostnote_0.8.20_amd64.deb -O /tmp/boostnote_0.8.20_amd64.deb
# install
$ sudo dpkg -i /tmp/boostnote_0.8.20_amd64.deb
# install missing depedencies
$ sudo apt-get -f install
# clean
rm /tmp/boostnote_0.8.20_amd64.deb
```

## TODO
* Generate an .AppImage of this standalone package, refers to https://github.com/AppImage/AppImages/

## Thanks
Thank to [Boostnote](https://github.com/BoostIO/Boostnote/) for this beautiful app ! :clap::+1::wink:

## Licence
LEMAIRE Quentin https://www.lemairepro.fr
