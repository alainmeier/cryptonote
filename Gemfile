source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

group :development do
  gem 'annotate'

  # Removes asset-related messages from server log
  gem 'quiet_assets'
end

group :production do
  # Required for Heroku asset serving
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end

# For geocoding and reverse geocoding
gem 'geocoder'

# Allows better management of ENV variables
gem 'figaro'

gem 'pg'

gem 'puma'

gem 'haml'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

gem 'compass-rails', github: 'milgner/compass-rails', ref: '1749c06f15dc4b058427e7969810457213647fb8'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end