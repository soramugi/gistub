namespace :deploy do

  after 'deploy:publishing', 'deploy:restart'
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

end
