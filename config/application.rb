require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"

ActionController::Railtie.initializer "puts default_protect_from_forgery when ActionController::Base is loaded" do
  ActiveSupport.on_load(:action_controller_base) do
    puts "default_protect_from_forgery is #{Rails.application.config.action_controller.default_protect_from_forgery}, expected: false"
  end
end

ActionController::Railtie.initializer "puts default_protect_from_forgery when application is initialized" do
  ActiveSupport.on_load(:after_initialize) do
    puts "default_protect_from_forgery is #{Rails.application.config.action_controller.default_protect_from_forgery}, expected: false"
  end
end

# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsConfig
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.before_configuration do
      puts "before_configuration"
    end

    config.before_initialize do
      puts "before_initialize"
    end

    config.after_initialize do
      puts "after_initialize"
    end

    initializer "before_initialize hook" do |app|
      ActiveSupport.on_load(:before_initialize) do
        puts "ActiveSupport.on_load(:before_initialize) runs at the end of before_initialize"
      end
    end

    initializer "after_initialize hook" do |app|
      ActiveSupport.on_load(:after_initialize) do
        puts "ActiveSupport.on_load(:after_initialize) runs at the end of after_initialize"
      end
    end

    puts "application.rb loaded"
  end
end
