sidekiq_config = { url: Rails.application.secrets.sidekiq[:redis_uri] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end
Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
