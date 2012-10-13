set :bundle_without, []
set :bundle_flags, ''
require "bundler/capistrano"

set :scm,        :git
set :repository, 'git@github.com:railsrumble/r12-team-349.git'

set :use_sudo,    false
set :user,       :deploy
set :deploy_via, :remote_cache
set :deploy_to,  '/var/www/inkedsites.com'
set :application, 'foosleague.com'
set :host, 'http://foosleague.r12.railsrumble.com/'
set(:application_root) { "/var/www/#{application}" }
set :keep_releases, 7
