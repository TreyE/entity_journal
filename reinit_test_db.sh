#!/bin/sh

bundle exec rake db:drop
bundle exec rake db:create
RAILS_ENV=test bundle exec rake sequent:db:create_event_store
RAILS_ENV=test bundle exec rake sequent:db:create_view_schema
RAILS_ENV=test bundle exec rake sequent:migrate:online
RAILS_ENV=test bundle exec rake sequent:migrate:offline
