source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'jquery-rails'
gem 'haml'
gem 'migrant'
gem 'rmagick', require: 'RMagick'
gem 'aws-s3', require: 'aws/s3'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

group :assets do
  gem 'sass-rails', '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'turn', '0.8.2', require: false
end

group :development do
  gem 'sqlite3'
  gem 'heroku'
end

group :production do
  gem 'pg'
end