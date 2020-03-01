module WidgetApi
  class Widget < Base
    def self.all(term = nil)
      response = Request.where("widgets/visible?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&term=#{term.to_s}")
      response['data'].fetch('widgets', [])
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
end
