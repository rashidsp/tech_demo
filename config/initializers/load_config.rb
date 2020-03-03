APP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/config.yml")[Rails.env]
CLIENT_ID = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']
# SITE = RestClient::Resource.new(APP_CONFIG['base_url'])
