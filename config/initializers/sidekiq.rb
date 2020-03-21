Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.sidekiq[:redis_uri] }
end
