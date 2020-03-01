APP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/config.yml")[Rails.env]
BASE_URL = APP_CONFIG['base_url']
CLIENT_ID = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']
