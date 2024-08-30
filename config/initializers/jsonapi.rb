JSONAPI::Rails.configure do |config|
  config.jsonapi_expose = lambda {
    { url_helpers: ::Rails.application.routes.url_helpers }
  }
end
