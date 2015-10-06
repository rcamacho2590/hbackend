CarrierWave.configure do |config|
  config.dropbox_app_key = ENV["app_key"]
  config.dropbox_app_secret = ENV["app_secret"]
  config.dropbox_access_token = ENV["access_token"]
  #config.dropbox_access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  config.dropbox_user_id = ENV["user_id"]
  config.dropbox_access_type = "dropbox"
end
