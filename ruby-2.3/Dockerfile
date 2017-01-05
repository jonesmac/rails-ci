FROM ruby:2.3

# Install system dependencies
RUN apt-get update -qq && apt-get -qq install -y \
    curl ca-certificates bzip2 imagemagick libfontconfig libmariadbd-dev libpq-dev xz-utils \
    --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/*

# Node
# https://hub.docker.com/_/node/

ENV NPM_CONFIG_LOGLEVEL error
ENV NODE_VERSION 7.4.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs
  
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
