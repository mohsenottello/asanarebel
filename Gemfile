source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem "active_model_serializers"
gem "bing_translator", "~> 6.0.0"
gem 'bootsnap', '>= 1.1.0', require: false
gem 'execjs'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 5.2.3'
gem 'redis', '~> 4.0'
gem 'sidekiq', '~> 5.2.5'
gem 'therubyracer'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
end
