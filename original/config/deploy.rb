set :application, "flingr"

set :scm, :git
set :repository,  "git@mail.martyhaught.com:flingr"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "marty"
set :use_sudo, false

set :deploy_to, "/var/www/#{application}"

server "teemhub.com", :app, :web, :db, :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Create symlinks for all shared files"
  task :symlink_shared do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml" 
  end  
end

after 'deploy:update_code', "deploy:symlink_shared"