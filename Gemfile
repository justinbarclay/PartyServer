source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'

gem 'pg',                      '0.18.4'
# Use Puma as the app server
gem 'puma', '~> 3.0'

gem "pry", "~> 0.10.3"
gem "pry-doc", ">= 0.8.0", require: false, platforms: :mri
gem "method_source", ">= 0.8.2"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

gem 'knock'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'postmark-rails'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'



group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rubocop'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
