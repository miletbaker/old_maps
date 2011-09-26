set :domain, "artemis.gotripod.com"

set :user, "deploy"

set :application, "www.oldmapsofparis.com"
set :branch, "production"

set :deploy_to, "/var/www/apps/#{application}"
set :use_sudo, false


default_run_options[:pty] = true
set :repository,  "git@github.com:miletbaker/old_maps.git"
set :ssh_options, { :forward_agent => true }
set :scm, "git"

set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do end
  task :stop do end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :omop do
  
  task :link_shared_db_conf do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end


end
after "deploy:update_code", "omop:link_shared_db_conf"
after "deploy", "deploy:cleanup"