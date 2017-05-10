require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lotus
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers

    config.time_zone = 'Beijing'

    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.helper = false
      g.assets = false
      g.test_framework = false
    end

    # autoload_paths 生产环境不执行autoloading
    config.autoload_paths += [ Rails.root.join('lib') ]
    config.eager_load_paths += [ Rails.root.join('lib') ]

    %w( qiniu redis ).each do |item|
      config.send(:"#{item}=", config_for(item).deep_symbolize_keys)
    end


    config.cache_store = :redis_store, config.redis

    config.active_job.queue_adapter = :sidekiq

  end
end
