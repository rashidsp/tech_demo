require 'faraday'
require 'json'

class Connection
  def self.api
    Faraday.new(url: APP_CONFIG['base_url']) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
    end
  end
end
