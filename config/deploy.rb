set :application, 'bedrock_test'
set :repo_url, 'git@github.com:adamkrone/bedrock-test'

set :branch, :master

set :deploy_to, '/var/www'

set :log_level, :info

# Apache users with .htaccess files:
# it needs to be added to linked_files so it persists across deploys:
# set :linked_files, %w{.env web/.htaccess}
set :linked_files, %w{.env}
set :linked_dirs, %w{web/app/uploads}

before 'deploy:finished', 'deploy:restart_lsyncd'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :service, :nginx, :reload
    end
  end

  desc 'Restart lsyncd'
  task :restart_lsyncd do
    on roles(:app), in: :sequence, wait: 5 do
      execute :service, :lsyncd, :restart
    end
  end
end

# The above restart task is not run by default
# Uncomment the following line to run it on deploys if needed
# after 'deploy:publishing', 'deploy:restart'
