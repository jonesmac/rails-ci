# Rails CI Image

## Backround

This image provides a base image for preforming various continuous integration tasks for Ruby on Rails applications.

## Flavors

This image comes in the following flavors:

- `latest` (see [ruby:latest](https://hub.docker.com/_/ruby/))
- `ruby-2.3` (see [ruby:2.3](https://hub.docker.com/_/ruby/))
- `ruby-2.4` (see [ruby:2.4](https://hub.docker.com/_/ruby/))
  
All images contain:

- Packages
  - curl
  - ca-certificates
  - bzip2
  - libfontconfig
  - imagemagick
  - libmariadbd-dev
  - libpq-dev
- [node 7.3.0](https://github.com/nodejs/node/blob/master/doc/changelogs/CHANGELOG_V7.md#7.3.0)
- [phantomjs 2.1.1](http://phantomjs.org/)
- [bundler config](https://bundler.io/v1.13/man/bundle-config.1.html)
  - `disable_exec_load=true` (see [bundler/bundler#5005](https://github.com/bundler/bundler/issues/5005))
  - `github.https=true`
- ENV
  - `RAILS_ENV=test`
  - `RACK_ENV=test`

## Rake Tasks

There are several rake tasks for building and pushing images.

To see a full list of tasks run:

- `$ rake -T`
