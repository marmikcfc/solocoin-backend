#!/bin/sh


bundle exec rails db:setup db:seed

bundle exec rails development_tasks:seed_dev_data

bundle exec foreman start