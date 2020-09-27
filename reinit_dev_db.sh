#!/bin/sh

bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake sequent:db:create_event_store
bundle exec rake sequent:db:create_view_schema
bundle exec rake sequent:migrate:online
bundle exec rake sequent:migrate:offline
