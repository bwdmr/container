# Rudimentary git-http-backend implementation

# Requirements:
#  - services; starting nginx and git
#  - nginx.conf; webserver configuration
#  - sshd_config; ssh configuration
#  - no-interactive-login; git-shell message
#  - .gitpasswd; auth for git repositories

# Quickstart
# NOTE: git repositories within /srv/git need to belong to www-data:www-data aka 82:82
# command: docker run -it -p 8080:80 -v ./git:/srv/git sha:XXX
###

# s6 overlay
FROM nginx:alpine

ENV S6_OVERLAY_VERSION="3.1.6.2"
ARG TARGETPLATFORM

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz

RUN if [ "$TARGETPLATFORM" = "x86_64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=aarch64; else ARCHITECTURE=x86_64; fi \
    && curl -sS -L -O --output-dir /tmp/ --create-dirs "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${ARCHITECTURE}.tar.xz" \
    && tar -C / -Jxpf "/tmp/s6-overlay-${ARCHITECTURE}.tar.xz" 

COPY ./services /etc/services.d/
RUN chmod 0755 /etc/services.d/fcgiwrap/run \
  && chmod 0755 /etc/services.d/nginx/run  \
  && chmod 0755 /etc/services.d/sshd/run \
  && rm -rf /etc/cont-init.

# install structure
RUN \
  apk fix \
  && apk --no-cache --update add git git-lfs git-daemon less openssh gnupg tar spawn-fcgi fcgiwrap apache2-utils nginx-mod-http-dav-ext \
  && ssh-keygen -A 

# nginx
RUN \
  set -x \
  && rm /var/log/nginx/error.log \
  && rm /var/log/nginx/access.log
COPY --chown=nginx:nginx ./nginx.conf /etc/nginx/nginx.conf

# git shell
RUN \
  git lfs install \
  && mkdir -v -m 0750 /home/git \
  && mkdir -v -m 0500 /home/git/git-shell-commands \
  && adduser -D -s /usr/bin/git-shell git \
  && sed -i 's/\(git:\)\!\(.*\)/\1\*\2/' /etc/shadow 
COPY --chown=git:git --chmod=0755 ./no-interactive-login /home/git/git-shell-commands/no-interactive-login

# git ssh
RUN \
  mkdir -v -m 0700 /home/git/.ssh \
  && mkdir -v -m 0700 /home/git/.ssh/authorized_keys.d \
  && touch /home/git/.ssh/authorized_keys \
  && chmod 0600 /home/git/.ssh/authorized_keys 
COPY --chown=root:root --chmod=0644 ./sshd_config /etc/ssh/sshd_config

RUN \
  mkdir -v -m 0750 /srv/git \
  && chown -R 82:82 /srv/git 
VOLUME /srv/git
COPY --chown=www-data:www-data --chmod=0400 ./gitpasswd /etc/nginx/.gitpasswd

EXPOSE 22 80 443
ENTRYPOINT [ "/init" ]
