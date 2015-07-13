require 'sidekiq/capistrano'
require 'new_relic/recipes'
#require "bundler/capistrano"

#set :whenever_roles, :cron
#set :whenever_command, "bundle exec whenever"
#set :whenever_environment, defer { stage }
#require "whenever/capistrano"

set :application, "Clipping"
set :repository,  "."
set :keep_releases, 3

set :scm, :none
set :deploy_via, :copy
set :checkout, 'export'
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, :deploy
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false
set :port, 22

set :server_name, "olm.puntopy.com"

role :web, server_name                          # Your HTTP server, Apache/etc
role :app, server_name                          # This may be the same as your `Web` server
role :db,  server_name, :primary => true # This is where Rails migrations will run
role :db,  server_name


# This goes out even if the deploy fails, sadly
#after "deploy", "newrelic:notice_deployment"
#after "deploy:update", "newrelic:notice_deployment"
#after "deploy:migrations", "newrelic:notice_deployment"
#after "deploy:cold", "newrelic:notice_deployment"

default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=production"
  end 
  #before "deploy", "deploy:web:disable"
  #after "deploy", "deploy:web:enable"
	desc "tail production log files" 
	task :tail_logs, :roles => :app do
	  trap("INT") { puts 'Interupted'; exit 0; }
	  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
	    puts  # for an extra line break before the host name
	    puts "#{channel[:host]}: #{data}" 
	    break if stream == :err
	  end
	end
end

namespace :uploads do

  desc <<-EOD
    Creates the upload folders unless they exist
    and sets the proper upload permissions.
  EOD
  task :setup, :except => { :no_release => true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
  end

  desc <<-EOD
    [internal] Creates the symlink to uploads shared folder
    for the most recently deployed version.
  EOD
  task :symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  desc <<-EOD
    [internal] Computes uploads directory paths
    and registers them in Capistrano environment.
  EOD
  task :register_dirs do
    set :uploads_dirs,    %w(uploads)
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end

  after       "deploy:finalize_update", "uploads:symlink"
  on :start,  "uploads:register_dirs"

end
