Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.cache_manager[:redis_uri] }
end
