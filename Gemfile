# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'dotenv-rails', '~> 3.1'
gem 'jbuilder'
gem 'jwt', '~> 2.10'
gem 'kaminari', '~> 1.2'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 8.0.1'
gem 'rails-i18n', '~> 8.0'
gem 'tzinfo-data', platforms: %i[windows jruby]

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', require: false
  gem 'database_cleaner', '~> 2.1'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'ostruct', '~> 0.6.1'
  gem 'pry', '~> 0.14.2'
  gem 'pry-byebug', '~> 3.10'
  gem 'rspec-rails', '~> 7.1'
  gem 'shoulda-matchers', '~> 6.4'

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  # gem "rubocop-rails-omakase", require: false
end

group :development do
  gem 'rubocop', '~> 1.71'
  gem 'rubocop-factory_bot', '~> 2.26'
  gem 'rubocop-performance', '~> 1.22'
  gem 'rubocop-rails', '~> 2.29'
  gem 'rubocop-rake', '~> 0.7.1'
  gem 'rubocop-rspec', '~> 3.5'
  gem 'rubocop-rspec_rails', '~> 2.30'
end
