#!/bin/bash
rm -rf tmp
bundle exec rake assets:precompile RAILS_ENV=production
bundle exec rake db:migrate RAILS_ENV=production
bundle exec rails s -p 3000 -b '0.0.0.0' -e production