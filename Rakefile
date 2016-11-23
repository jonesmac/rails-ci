# frozen_string_literal: true
desc 'Builds base image'
task :build do
  Rake::Task['build:ruby'].invoke
end

namespace :build do
  desc 'Builds base image'
  task :base do
    sh 'docker build -t registry.dxydoes.com/docker/ruby:latest .'
  end
  
  desc 'Builds image with elasticsearch'
  task :elasticsearch do
    sh 'docker build -t registry.dxydoes.com/docker/ruby:elasticsearch -f Dockerfile-elasticsearch .'
  end
end

desc 'Pushes base image'
task :push do
  Rake::Task['push:base'].invoke
end

namespace :push do
  desc 'Pushes base image to the registry'
  task :base do
    sh 'docker push registry.dxydoes.com/docker/ruby:latest'
  end
  
  desc 'Pushes image with elasticsearch to the registry'
  task :elasticsearch do
    sh 'docker push registry.dxydoes.com/docker/ruby:elasticsearch'
  end
end

desc 'Builds & pushes all docker images'
task :deploy do
  Rake::Task['deploy:base'].invoke
end

namespace :deploy do
  desc 'Builds & pushes base image to the registry'
  task :base do
    Rake::Task['build:base'].invoke
    Rake::Task['push:base'].invoke
  end
  
  desc 'Builds & pushes image with elasticsearch to the registry'
  task :elasticsearch do
    Rake::Task['build:elasticsearch'].invoke
    Rake::Task['push:elasticsearch'].invoke
  end
end
