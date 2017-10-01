namespace :ci do
  task :all => ['ci:setup:rspec', 'rspec']
end
