require 'rest-client'

class Widget

  attr_accessor :errors, :id, :name, :description, :kind

  def self.all(term = nil)
    response = RestClient.get "#{APP_CONFIG['base_url']}/api/v1/widgets/visible", {
     params: {
      term: term.to_s,
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET
     }
    }
    response_body = JSON.parse(response.body)
    response_body['data'].fetch('widgets', [])
  end

  def self.user_widgets(term: nil, token: {})

    return [] unless token.present?

    headers = {
     Authorization: token['token_type'] + " " + token['access_token'],
     content_type: 'application/json',
     accept: :json
    }

    response = RestClient.get(
     "#{APP_CONFIG['base_url']}/api/v1/widgets?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&term=#{term.to_s}",
     headers
    )
    
    response_body = JSON.parse(response.body)
    response_body['data'].fetch('widgets', [])
  end

  def initialize(widget: {}, token: {})
    @errors = []
    @id = widget[:id]
    @name = widget[:name]
    @description = widget[:description]
    @kind = widget[:kind].present? ? 'visible' : 'hidden'
    @token = token
  end

  def save!
    save_widget!("post", "#{APP_CONFIG['base_url']}/api/v1/widgets")
  end

  def update!
    save_widget!("put","#{APP_CONFIG['base_url']}/api/v1/widgets/#{@id}")
  end

  def delete!
    headers = {
     Authorization: @token['token_type'] + " " + @token['access_token'],
     content_type: 'application/json',
     accept: :json
    }

   response = RestClient::Request.execute(
     method: :delete,
     url: "#{APP_CONFIG['base_url']}/api/v1/widgets/#{@id}",
     headers: headers
    )

    response_body = JSON.parse(response.body)
    unless response_body['code'] == 0
     @errors.push(response_body['message'])
     return false
    end
    return true
  end

  private

  def save_widget!(method, url)
    headers = {
     Authorization: @token['token_type'] + " " + @token['access_token'],
     content_type: 'application/json',
     accept: :json
    }

    payload = {
      widget: {
        name: @name,
        description: @description,
        kind: @kind
      }
    }

   if method == 'post'
     RestClient.post(url, payload.to_json, headers) do |response, request, result|
       response_body = JSON.parse(response.body)
       unless response_body['code'] == 0
        @errors.push(response_body['message'])
        return false
       end
       return true
     end
   elsif method == 'put'
    RestClient.put(url, payload.to_json, headers) do |response, request, result|
      response_body = JSON.parse(response.body)
      unless response_body['code'] == 0
       @errors.push(response_body['message'])
       return false
      end
      return true
    end
   end
  end
end
