# frozen_string_literal: true
desc 'Builds latest image'
task :build do
  Rake::Task['build:latest'].invoke
end

namespace :build do
  desc 'Builds all images'
  task :all do
    Rake::Task['build:latest'].invoke
    Rake::Task['build:ruby_2_4'].invoke
    Rake::Task['build:ruby_2_3'].invoke
  end
  
  desc 'Builds latest image'
  task :latest do
    sh 'docker pull ruby:latest'
    sh 'docker build -t dsexton/rails-ci:latest .'
  end
  
  desc 'Builds ruby 2.3 image'
  task :ruby_2_3 do
    sh 'docker pull ruby:2.3'
    sh 'docker build -t dsexton/rails-ci:ruby-2.3 -f ruby-2.3/Dockerfile .'
  end
  
  desc 'Builds ruby 2.4 image'
  task :ruby_2_4 do
    sh 'docker pull ruby:2.4'
    sh 'docker build -t dsexton/rails-ci:ruby-2.4 -f ruby-2.4/Dockerfile .'
  end
end

desc 'Pushes latest image'
task :push do
  Rake::Task['push:latest'].invoke
end

namespace :push do
  desc 'Pushes all images'
  task :all do
    Rake::Task['push:latest'].invoke
    Rake::Task['push:ruby_2_3'].invoke
    Rake::Task['push:ruby_2_4'].invoke
  end

  desc 'Pushes latest image to the registry'
  task :latest do
    sh 'docker push dsexton/rails-ci:latest'
  end
  
  desc 'Pushes ruby-2.3 image to the registry'
  task :ruby_2_3 do
    sh 'docker push dsexton/rails-ci:ruby-2.3'
  end
  
  desc 'Pushes ruby-2.4 image to the registry'
  task :ruby_2_4 do
    sh 'docker push dsexton/rails-ci:ruby-2.4'
  end
end

desc 'Builds & pushes all docker images'
task :deploy do
  Rake::Task['deploy:latest'].invoke
end

namespace :deploy do
  desc 'Builds & pushes all images'
  task :all do
    Rake::Task['deploy:latest'].invoke
    Rake::Task['deploy:ruby_2_3'].invoke
    Rake::Task['deploy:ruby_2_4'].invoke
  end

  desc 'Builds & pushes latest image to the registry'
  task :latest do
    Rake::Task['build:latest'].invoke
    Rake::Task['push:latest'].invoke
  end
  
  desc 'Builds & pushes ruby-2.3 image to the registry'
  task :ruby_2_3 do
    Rake::Task['build:ruby_2_3'].invoke
    Rake::Task['push:ruby_2_3'].invoke
  end
  
  desc 'Builds & pushes ruby-2.4 image to the registry'
  task :ruby_2_4 do
    Rake::Task['build:ruby_2_4'].invoke
    Rake::Task['push:ruby_2_4'].invoke
  end
end
