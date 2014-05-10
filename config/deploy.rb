require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :domain, 'digester.io'
set :deploy_to, '/webapps/digester.io'
set :repository, 'git@github.com:alexmchale/atomic_digester.git'
set :branch, 'master'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, %w( config/database.yml config/secrets.yml log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system )

# Optional settings:
set :user, 'alexmchale'
set :port, 22

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # Configure rbenv.
  echo "Configuring rbenv"
  queue! %[export RBENV_ROOT="/usr/local/rbenv"]
  queue! %[export PATH="$RBENV_ROOT/bin:$PATH"]
  queue! %[eval "$(rbenv init -)"]
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/secrets.yml'."]

  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/cache"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/cache"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]

  queue! %[mkdir -p "#{deploy_to}/shared/vendor/bundle"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/vendor/bundle"]

  queue! %[mkdir -p "#{deploy_to}/shared/public/system"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/system"]

end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue "RAILS_ENV=production bin/puma.sh restart"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
