require 'bundler/capistrano'
require 'whenever/capistrano'

set :user, 'shivraj'
set :domain, '192.211.52.53'  
set :ssh_options, { :forward_agent => true }
set :application, "/var/www/bigbluebutton"
set :use_sudo, false
set :scm, 'git'
set :repository,  "git@github.com:reponame/b3techzoo.git"
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :whenever_command, "bundle exec whenever"
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
#set :repository_cache, "git_cache"
set :git_shallow_clone, 1
set :scm_verbose, true
set :keep_releases, 1
set :default_environment, {
  'LANG' => 'en_US.UTF-8'
}

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

print "stage 1 ............."

after :deploy, "gems:install"

print "stage 2 ............."
after "gems:install", "deploy:migrate"
# deploy config

print "stage 3 .............."
set :deploy_to, application
#set :deploy_via, :remote_cache

print "stage 4 .............."
# Passenger
namespace :deploy do
  task :start do
    run "/etc/init.d/apache2 start"
    puts "starting apache..."
  end
  task :stop do
    run "/etc/init.d/apache2 stop"
    puts " stopping apache..."
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    puts "Currnt path mkdir"
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
  
  after "deploy:update_code", :symlink
  print "stage 5 .............."
  
  
  
  #recently added ..........
  after "deploy:symlink", "deploy:restart"
  
#  after "deploy:symlink", "deploy:update_crontab"
#  print "stage 6 .............."
#   
#  after "deploy:update_crontab", "deploy:restart"
#  print "stage 7 .............."
end

#after "deploy:symlink_configs", "new_sphinx:configure" #this line is executing two times
#print "stage 8 .............."

#recently added ........
#after "deploy:symlink", "deploy:update_crontab"
#print "stage 11 .............."

#recently added
#namespace :deploy do
#  desc "Update the crontab file"
#  task :update_crontab, :roles => :db do
#    run "cd #{latest_release} && whenever --update-crontab #{application}"
#  end
#end

desc "Link to the configuration"
task :symlink do
  run "ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
end

after "deploy:update", "deploy:cleanup"
print "stage 12 .............."
