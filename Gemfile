source 'https://rubygems.org'

gem 'rails', '3.2.0.rc2'

gem 'pg'
gem 'jquery-rails'
gem 'will_paginate'
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git'
gem 'devise', '2.0.0.rc'
gem 'capistrano'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'therubyracer', require: false
  gem 'uglifier'
end

group :development do
  gem 'ruby-debug19', require: 'ruby-debug'
  gem 'mongrel', '1.2.0.pre2'
end

group :test do
  gem 'turn', require: false
  gem 'minitest', require: false
  gem 'capybara', require: false
  gem 'fabrication'
  gem 'faker'
  gem 'database_cleaner' # For Capybara
end
