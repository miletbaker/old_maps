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
  
  task :create_db_backup_dir do
    run "mkdir -p #{shared_path}/db"
  end
  
  task :link_shared_db_conf do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :backup_database do
    run "ls -xt #{shared_path}/db/" do |ch, stream, data|
      files = data.split
      if files.length > 5
        files[5..files.length-1 ].each do |file|
        run "rm #{shared_path}/db/#{file}"
      end
      end
    end
    run "mysqldump -u omop_production --password=Yih71CQLKA omop_production > #{shared_path}/db/#{releases.last}.sql"
  end

end
after "deploy:setup", "omop:create_db_backup_dir"
before "deploy", "omop:backup_database"
after "deploy", "omop:link_shared_db_conf"
after "deploy", "deploy:cleanup"