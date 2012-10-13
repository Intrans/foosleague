set :bundle_without, []
set :bundle_flags, ''
require "bundler/capistrano"

set :scm,        :git
set :repository, 'git@github.com:railsrumble/r12-team-349.git'

set :use_sudo,    false
set :user,       :deploy
#set :deploy_via, :remote_cache
set :deploy_to,  '/var/www/foosleague.com'
set :application, 'foosleague.com'
set :host, 'foosleague.r12.railsrumble.com'
set(:application_root) { "/var/www/#{application}" }
set :keep_releases, 7

role :app, host
role :web, host
role :db,  host, :primary => true

namespace :assets do

  desc "Comple all the assets for the asset pipeline"
  task :precompile do
    run "cd #{current_path} && rake assets:precompile"
  end
end

namespace :config do

  desc 'Symlink in the relevent server sepecific configurations'
  task :symlink, :roles => :app do
    [ 'database.yml', 'application.yml' ].each do |file|
      run "ln -sf #{shared_path}/config/#{file} #{release_path}/config/#{file}"
    end
  end

  desc 'Create the shared config directory for configuration persistance between deploys'
  task :create_directory do
    run "mkdir -p #{shared_path}/config"
  end

end

after  "deploy:setup",   "config:create_directory"

after  "deploy:create_symlink", "assets:precompile"

before "deploy:create_symlink", "config:symlink"

after 'deploy:create_symlink', 'deploy:cleanup'
