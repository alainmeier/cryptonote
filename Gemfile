source 'https://rubygems.org'
ruby '2.3.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0', '>= 5.0.0.1'
gem 'rake', '~> 11.2.2'

group :development, :docker, :test do
  gem 'annotate', '~> 2.6.3'
  gem 'sqlite3'
end

group :production do
  # Required for Heroku asset serving
  gem 'rails_12factor', '~> 0.0.3'
  gem 'pg', '~> 0.18.4'
end

# Allows better management of ENV variables
gem 'figaro', '~> 1.1', '>= 1.1.1'

gem 'puma', '~> 3.6'

gem 'slim', '~> 3.0', '>= 3.0.7'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0', '>= 5.0.6'

# A CSS pre-processor toolkit
gem 'bourbon', '~> 4.2', '>= 4.2.7'
gem 'neat', '~> 1.8'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0', '>= 3.0.1'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2', '>= 4.2.1'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.1', '>= 4.1.1'

gem 'clipboard-rails', '~> 1.7.1'

gem 'markdownjs-rails', '~> 1.0', '>= 1.0.2'
