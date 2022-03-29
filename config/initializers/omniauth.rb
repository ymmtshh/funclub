Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'],info_fields:"nickname", request_path: '/auth/twitter', callback_url: 'http://127.0.0.1:3000/auth/twitter/callback'
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'],info_fields:"nickname", request_path: '/auth/another/twitter', callback_url: 'http://127.0.0.1:3000/auth/another/twitter/callback'
end
