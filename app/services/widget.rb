require 'rest-client'

class Widget
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

  # def self.find(id)
  #   response = Request.get("recipes/#{id}/information")
  #   Recipe.new(response)
  # end
  #
  # def initialize(args = {})
  #   super(args)
  #   self.ingredients = parse_ingredients(args)
  #   self.instructions = parse_instructions(args)
  # end
  #
  # def parse_ingredients(args = {})
  #   args.fetch("extendedIngredients", []).map { |ingredient| Ingredient.new(ingredient) }
  # end
  #
  # def parse_instructions(args = {})
  #   instructions = args["analyzedInstructions"]
  #   if instructions
  #     steps = instructions.first.fetch("steps", [])
  #     steps.map { |instruction| Instruction.new(instruction) }
  #   end
  # end
end
