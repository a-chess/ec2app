set :rails_env, "production"
set :unicorn_rack_env, "production"

role :app, %W(hyuga@#{ENV['DEPLOY_SV_EC2APP']})
role :web, %W(hyuga@#{ENV['DEPLOY_SV_EC2APP']})
role :db,  %W(hyuga@#{ENV['DEPLOY_SV_EC2APP']})

server ENV['DEPLOY_SV_EC2APP'], user: 'hyuga', roles: %w{web app}

set :ssh_options, {
  forward_agent: true,
  user: fetch(:user),
  keys: ["#{ENV['SERVICE_NAME_PRODUCTION_SSH_KEY']}"]
}