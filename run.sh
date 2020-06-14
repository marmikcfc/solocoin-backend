#!/bin/sh
set -e

# Ensure the app's dependencies are installed
echo "bundle install..."
gem update --system
gem update bundler
bundle install 

# Wait for Postgres to become available.
echo "Checking for Postgres..."
until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done
echo "Postgres is available: continuing with database setup..."

# Potentially Set up the database
echo "bundle exec rails db:setup..."
bundle exec rails db:setup db:seed

echo "bundle exec rails development_tasks..."
bundle exec rails development_tasks:seed_dev_data

echo "bundle exec foreman start..."
bundle exec foreman start

