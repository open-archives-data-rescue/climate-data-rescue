#!/usr/bin/env sh
export NODE_ENV=${RAILS_ENV}

# Development environment setup runs when RAILS_ENV is not set
if [[ -z $RAILS_ENV ]] || [[ $RAILS_ENV = "development" ]]; then
  gem install bundler:1.17.3
  bin/bundle install --quiet
  bin/vite install
else
  until ! mysqladmin ping -h"$DB_HOST" --silent; do
    echo "waiting for database..."
    sleep 5
  done
fi

bin/bundle exec sidekiq
