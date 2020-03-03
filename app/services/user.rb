class User
  attr_accessor :first_name, :last_name, :email, :image_url

  def initialize(first_name = nil, last_name = nil, email = nil, image_url = nil)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @image_url = image_url
  end

  def create
    
  end
end
