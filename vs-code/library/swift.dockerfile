# swift 
ENV DEBCONF_NONINTERACTIVE_SEEN=true
ENV SWIFT_SIGNING_KEY=A62AE125BBBFBB96A6E042EC925CC1CCED3D1561
ENV SWIFT_PLATFORM=ubuntu18.04
ENV SWIFT_BRANCH=swift-5.5-release
ENV SWIFT_VERSION=swift-5.5-RELEASE
ENV SWIFT_WEBROOT=https://swift.org/builds/
RUN add-apt-repository ppa:deadsnakes/ppa \
  && apt update -y \
  && apt install -y python3.6 \
    libpython3.6-dev 

RUN apt-get install -y \
  libatomic1 \
  binutils \
  git \
  gnupg2 \
  libc6-dev \
  libcurl4 \
  libedit2 \
  libgcc-9-dev \
  libncurses5 \
  libpython2.7 \
  libsqlite3-0 \
  libstdc++-9-dev \
  libtinfo5 \
  libxml2 \
  libz3-dev \
  pkg-config \
  tzdata \
  uuid-dev \
  zlib1g-dev

RUN SWIFT_WEBDIR="$SWIFT_WEBROOT/$SWIFT_BRANCH/$(echo $SWIFT_PLATFORM | tr -d .)/"\
  && SWIFT_BIN_URL="$SWIFT_WEBDIR/$SWIFT_VERSION/$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz" \
  && SWIFT_SIG_URL="$SWIFT_BIN_URL.sig" \
  && curl -fsSL "$SWIFT_BIN_URL" -o swift.tar.gz "$SWIFT_SIG_URL" -o swift.tar.gz.sig

RUN tar -xzf swift.tar.gz --directory / --strip-components=1 \
  && chmod -R o+r /usr/lib/swift \
  && rm -rf swift.tar.gz.sig swift.tar.gz