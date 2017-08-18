# Load DSL and set up stages
require 'capistrano/setup'
# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/rails'

# bundle exec cap digital ocean:init;bundle exec cap production deploy; bundle exec cap digital ocean:restart

namespace :ocean do

  desc "Prepare for digital ocean deploy"
  task :init do
    on roles(:rooter) do
      execute 'echo "STARTING DIGITAL OCEAN INITIAL CONFIGURATION!"'
    end
  end

  desc "Configure swap file in droplet (4GB)"
  task :swap do
    on roles(:rooter) do
      execute 'sudo fallocate -l 4G /swapfile'
      execute 'ls -lh /swapfile'
      execute 'sudo chmod 600 /swapfile'
      execute 'sudo mkswap /swapfile'
      execute 'sudo swapon /swapfile'
      execute 'sudo swapon -s'
      execute 'free -m'
      execute "echo '/swapfile   none    swap    sw    0   0' >> /etc/fstab"
    end
  end

  desc "Add language vars"
  task :add_language do
    on roles(:rooter) do
      execute 'LANGUAGE="en_US.UTF-8"'
      execute 'LANGUAGE="en_US.UTF-8"'
      execute %Q[echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale]
      execute %Q[echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale]
    end
  end

  desc "remove old rails_project"
  task :remove_old do
    on roles(:rooter) do
      execute 'rm -R /home/rails/rails_project/'
    end
  end

  desc "Add ssh keys to server"
  task :add_keys do
    on roles(:rooter) do
      cat = capture :cat, '/etc/motd.tail'
      pass = cat.lines[7].sub('* Pass:','').strip
      execute "echo #{pass}"
    end
    role_properties(:rooter) do |hostname, role, props|
      run_locally do
        execute "cat ~/.ssh/id_rsa.pub | ssh rails@#{hostname} 'mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys'"
      end
    end
  end

  desc "Add the variables to bashrc"
  task :add_vars do
    on roles(:rooter) do
      execute "tail -n +25 /etc/default/unicorn > /home/rails/variables"
      execute "head -n +24 /etc/default/unicorn > header"
      execute "cat header > /etc/default/unicorn"
      execute "echo '. /home/rails/variables' >> /etc/default/unicorn"
      execute "echo '. /home/rails/variables' | cat - /home/rails/.bashrc > temp && mv temp /home/rails/.bashrc"
    end
  end

  desc "restart unicorn (Non zero downtime)"
  task :restart do
    on roles(:rooter) do
      execute "service unicorn restart"
    end
  end


  #FLOW
  after :init, :swap
  after :init, :add_language
  after :init, :remove_old
  after :init, :add_keys
  after :init, :add_vars

end

namespace :deploy do

  desc "Symlink current to rails proyect"
  task :add_symlink do
    on roles(:web) do
      execute 'ln -s /home/rails/current /home/rails/rails_project'
    end
  end

  desc "Symlink public system files (images)"
  task :add_symlink do
    on roles(:web) do
      execute 'ln -s /home/rails/shared/public/system /home/rails/current/public/system'
    end
  end

  after :finishing, :add_symlink

end

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
