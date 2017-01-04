SIDEKIQ_CONFIG = {
  url: ENV['EMILITO_SIDEKIQ_REDIS_URL'],
  namespace: ENV['EMILITO_SIDEKIQ_REDIS_NAMESPACE']
}.freeze

Sidekiq.configure_server do |config|
  config.redis = SIDEKIQ_CONFIG.dup
end

Sidekiq.configure_client do |config|
  config.redis = SIDEKIQ_CONFIG.dup
end
