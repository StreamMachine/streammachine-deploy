set :application, "streammachine-deploy"

set :scm, :git
set :repository,  "git@github.com:StreamMachine/streammachine-deploy.git"
set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache

set :deploy_to, "/web/streammachine"

set :user, "streammachine"
set :use_sudo, false

role :app, "ericrichardson.com"

namespace :deploy do
  task :start do
    run "touch #{current_release}/tmp/restart.txt"
  end
  task :stop do
    # do nothing
  end
  task :restart do
    run "touch #{current_release}/tmp/restart.txt"
  end
  
  desc 'Build NPM packages'
  task :npm do
    run "cd #{release_path} && npm install && npm rebuild"
  end
end

after :'deploy:update_code', :'deploy:npm'