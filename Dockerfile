FROM ruby:latest

# Add Official Postgres Repo
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

# Install system dependencies
RUN apt-get update -qq && apt-get -qq install -y \
    curl ca-certificates bzip2 imagemagick libfontconfig \
    libmariadbd-dev libpq-dev mariadb-client postgresql-client xz-utils \
    --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/*

# Docker
# https://hub.docker.com/_/docker/

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 17.05.0-ce
ENV DOCKER_SHA256_x86_64 340e0b5a009ba70e1b644136b94d13824db0aeb52e09071410f35a95d94316d9
ENV DOCKER_SHA256_armel 59bf474090b4b095d19e70bb76305ebfbdb0f18f33aed2fccd16003e500ed1b7
ENV DOCKER_ARCH x86_64

RUN set -ex; \
  	curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/${DOCKER_ARCH}/docker-${DOCKER_VERSION}.tgz" -o docker.tgz; \
    # /bin/sh doesn't support ${!...} :(
    sha256="DOCKER_SHA256_${DOCKER_ARCH}"; sha256="$(eval "echo \$${sha256}")"; \
    echo "${sha256} *docker.tgz" | sha256sum -c -; \
    tar -xzvf docker.tgz; \
    mv docker/* /usr/local/bin/; \
    rmdir docker; \
    rm docker.tgz; \
    docker -v

# Node
# https://hub.docker.com/_/node/

ENV NPM_CONFIG_LOGLEVEL error
ENV NODE_VERSION 8.1.1

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN npm set progress=false && \
    npm install -g --progress=false yarn && \
    npm cache clean

# Install phantomjs
ENV PHANTOMJS_VERSION 2.1.1

RUN curl -SLO "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" \
    && mkdir "phantomjs-$PHANTOMJS_VERSION-linux-x86_64" \
    && tar -jxvf "phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" -C "phantomjs-$PHANTOMJS_VERSION-linux-x86_64" --strip-components=1 \
    && mv "phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs" /usr/local/bin \
    && rm -rf "phantomjs-$PHANTOMJS_VERSION-linux-x86_64" "phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2"

# Bug with bundler 1.13
# See: https://github.com/bundler/bundler/issues/5005
RUN bundle config disable_exec_load true

# Use HTTPS instead of SSH
RUN bundle config github.https true

# Set Rails to run in production
ENV RAILS_ENV test
ENV RACK_ENV test
