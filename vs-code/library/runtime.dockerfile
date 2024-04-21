USER user

# setup nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# pnpm
ENV SHELL="/bin/bash"
RUN curl -fsSL https://get.pnpm.io/install.sh | sh - 
ENV PATH="/home/user/.local/share/pnpm:${PATH}"

# user related config:
RUN sed -i 's/\(#umask\)/umask/' ~/.profile