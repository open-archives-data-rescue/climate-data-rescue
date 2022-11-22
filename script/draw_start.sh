#!/usr/bin/env sh
export NODE_ENV=${RAILS_ENV}

# Development environment setup runs when RAILS_ENV is not set
if [[ -z $RAILS_ENV ]] || [[ $RAILS_ENV = "development" ]]; then
  gem install bundler:1.17.3
  bin/bundle install --quiet

  bin/yarn install --frozen-lockfile
  bin/rails webpacker:install -n
  bin/webpack-dev-server --host 0.0.0.0 &

  bin/rake db:db_missing || (bin/rails db:create; bin/rails db:setup)
  bin/rake db:migrate
elif [[ $RAILS_ENV = "staging" ]]; then
  bin/rake db:db_missing || (bin/rails db:create; bin/rails db:setup)

  bin/rake db:migrate

  # asset compilation
  NODE_ENV=development bin/rake assets:precompile
else
  until ! mysqladmin ping -h"$DB_HOST" --silent; do
    echo "waiting for database..."
    sleep 5
  done

  bin/rake db:db_missing || (bin/rails db:create; bin/rails db:structure:load)

  bin/rake db:migrate
  # asset compilation
  NODE_ENV=development bin/rake assets:precompile
fi

bin/rails server -b 0.0.0.0
