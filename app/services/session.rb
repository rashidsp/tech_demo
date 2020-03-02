require 'rest-client'

class Session
  attr_accessor :email, :password, :errors, :token

  def initialize(user: {}, token: {})
    @email = user[:email]
    @password = user[:password]
    @errors = []
    @token = token
  end

  def current_user
   return nil unless @token.present?

   response = RestClient.get "#{APP_CONFIG['base_url']}/api/v1/users/me",
    {
      Authorization: @token['token_type'] + " " + @token['access_token']
    }
   response_body = JSON.parse(response.body)
   response_body['data'].fetch('user', {})
  end

  def login!
    payload = {
     grant_type: "password",
     username: @email,
     password: @password,
     client_id: CLIENT_ID,
     client_secret: CLIENT_SECRET
    }
    # response = RestClient.post("#{APP_CONFIG['base_url']}/oauth/token", payload, {content_type: :json, accept: :json})
    RestClient.post("#{APP_CONFIG['base_url']}/oauth/token", payload.to_json, {content_type: 'application/json', accept: :json}) do |response, request, result|
      response_body = JSON.parse(response.body)
      unless response_body['code'] == 0
       @errors.push(response_body['message'])
       return false
      end
      @token = response_body['data'].fetch('token', {})
      return true
    end
  end

  def revoke!
    headers = {
     Authorization: @token['token_type'] + " " + @token['access_token'],
     content_type: 'application/json',
     accept: :json
    }

    payload = {
     token: @token['access_token']
    }

    RestClient.post(
     "#{APP_CONFIG['base_url']}/oauth/revoke", payload, headers) do |response, request, result|
      response_body = JSON.parse(response.body)
      unless response_body['code'] == 0
       @errors.push(response_body['message'])
       return false
      end
      return true
    end
  end

  def reset_password!
    payload = {
     user: { email: @email },
     client_id: CLIENT_ID,
     client_secret: CLIENT_SECRET
    }
    # response = RestClient.post("#{APP_CONFIG['base_url']}/oauth/token", payload, {content_type: :json, accept: :json})
    RestClient.post("#{APP_CONFIG['base_url']}/api/v1/users/reset_password", payload.to_json, {content_type: 'application/json', accept: :json}) do |response, request, result|
      response_body = JSON.parse(response.body)
      unless response_body['code'] == 0
       @errors.push(response_body['message'])
       return false
      end
      return true
    end
  end

end
