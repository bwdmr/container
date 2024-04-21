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