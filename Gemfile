source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jenkins-rails'
gem 'jquery-rails'
gem 'active_model_serializers', '~> 0.10.0'
gem 'bcrypt', '~> 3.1.7'
gem 'faker'
gem "brakeman", :require => false
gem 'simplecov', :require => false, :group => :test
gem "paperclip", "~> 5.0.0"
gem "simple_calendar", "~> 2.0"
gem 'twilio-ruby', '~> 4.11.1'
gem "figaro"
gem 'kaminari'
gem 'ci_reporter'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'pry'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
