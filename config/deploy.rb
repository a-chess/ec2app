# config valid only for Capistrano 3.1
lock '3.11.0'

set :application, 'trial-circle'
set :repo_url, 'git@github.com:a-chess/ec2app.git'
set :branch, 'master'
set :deploy_to, '/home/hyuga/ec2app'
set :log_level, :debug
set :pty, true
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}
set :linked_files, %w{config/master.key}
set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
set :keep_releases, 5
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

after 'deploy:publishing' , 'deploy:restart'

# deploy:assets:backup_manifestはなんかエラーになるんで実行させない。
Rake::Task['deploy:assets:backup_manifest'].clear_actions

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end

