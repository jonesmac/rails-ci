FROM ruby:2.3

# Node
# https://hub.docker.com/_/node/

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 7.1.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Install system dependencies
RUN apt-get update -qq && apt-get -qq install -y \
    imagemagick libmariadbd-dev libpq-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Install phantomjs
RUN npm install -g phantomjs-prebuilt >/dev/null

# Set Rails to run in production
ENV RAILS_ENV test
ENV RACK_ENV test
