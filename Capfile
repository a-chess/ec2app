require 'capistrano/setup'
require "capistrano/deploy"
require "capistrano/scm/git"
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'

install_plugin Capistrano::SCM::Git

# デプロイ先のサーバで、ユーザディレクトリでrbenvをインストールしている場合
set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
