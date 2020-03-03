require 'rest-client'

class Register
  attr_accessor :user, :errors, :token
  def initialize(user: {}, token: {})
    @user = user
    @user[:image_url] = "https://static.thenounproject.com/png/961-200.png"
    @errors = []
    @token = token
  end

  def save!
    payload = {
     user: @user,
     client_id: CLIENT_ID,
     client_secret: CLIENT_SECRET
    }

    RestClient.post("#{APP_CONFIG['base_url']}/api/v1/users", payload.to_json, {content_type: 'application/json', accept: :json}) do |response, request, result|
      response_body = JSON.parse(response.body)
      unless response_body['code'] == 0
       @errors.push(response_body['message'])
       return false
      end
      @token = response_body['data'].fetch('token', {})
      return true
    end
  end

  def update!
    headers = {
     Authorization: @token['token_type'] + " " + @token['access_token'],
     content_type: 'application/json',
     accept: :json
    }

    payload = {
     user: @user
    }

    RestClient.put(
     "#{APP_CONFIG['base_url']}/api/v1/users/me",
     payload.to_json, headers
    ) do |response, request, result|
      response_body = JSON.parse(response.body)
      unless response_body['code'] == 0
       @errors.push(response_body['message'])
       return false
      end
      return true
    end
  end
end
