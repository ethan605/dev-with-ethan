module SecretMessengerApi
  class Application < Rails::Application
    # ...

    config.generators do |g|
      g.orm             :active_record
      g.template_engine nil
      g.test_framework  nil
      g.stylesheets     false
      g.javascripts     false
    end

    # ...
  end
end
