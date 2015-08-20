# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'gistub'

set :scm, :copy
set :exclude_dir, %w|
vendor/bundle
.git/
.bundle/
log/*
public/system/
tmp/*
db/*.sqlite3
.env
coverage
|

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}
set :linked_files, %w{.env db/production.sqlite3}

set :keep_releases, 5
