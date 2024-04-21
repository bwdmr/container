# php with composer
RUN add-apt-repository -y ppa:ondrej/php
RUN apt update -y \
  && apt install -y \
    wget \
    php8.1 \
    php8.1-apcu \
    php8.1-bcmath \
    php8.1-cli \
    php8.1-curl \
    php8.1-dom \
    php8.1-gd \
    php8.1-gmp \
    php8.1-mbstring \
    php8.1-mysql \
    php8.1-mysqli \
    php8.1-zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && export HASH="$(wget -q -O - https://composer.github.io/installer.sig)" \
  && php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') {echo 'Installer verified';} else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && composer require --dev sebastian/object-reflector \
  && composer require --dev symfony/test-pack \
  && rm -rf /composer-setup.php /composer.json /composer.lock

# symfony
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash \
  && apt install symfony-cli 