# base
ENV DEBIAN_FRONTEND=noninteractive
RUN useradd -m -s /bin/bash user -u 501 -g 20
RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    software-properties-common \
    tzdata

# node
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g \
    yarn \
    typescript \
    marked \
    dockerfile-language-server-nodejs \
    typescript-language-server \
    vscode-css-languageserver-bin \
    intelephense \
    eslint \
    prettier \
    gulp-cli \
    serve

# latex
RUN apt-get -y install \
  latexmk \
  texinfo \
  texlive-luatex \
  texlive-latex-extra \
  texlive-bibtex-extra \
  texlive-formats-extra \
  texlive-fonts-extra \
  texlive-lang-all

RUN mkdir /home/user/texmf \
  && curl -k 'https://raw.githubusercontent.com/darwiin/yaac-another-awesome-cv/master/yaac-another-awesome-cv.cls' \
  -o /home/user/texmf/yaac-another-awesome-cv.cls

# tools
RUN apt install -y \
  imagemagick

USER user

# setup nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# pnpm
ENV SHELL="/bin/bash"
RUN curl -fsSL https://get.pnpm.io/install.sh | sh - 
ENV PATH="/home/user/.local/share/pnpm:${PATH}"

# user related config:
RUN sed -i 's/\(#umask\)/umask/' ~/.profile