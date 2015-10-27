Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["twitter_publishable_key"], ENV["twitter_secret_key"]
end