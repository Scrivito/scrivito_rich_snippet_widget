module RichSnippet
  class Recipe < Thing
    attribute :prep_time, :integer
    attribute :total_time, :integer
    attribute :cook_time, :integer
    attribute :cooking_method, :string
    attribute :recipe_yield, :integer
    attribute :recipe_ingredients, :stringlist
    attribute :recipe_cuisine, :string
    attribute :recipe_category, :string
    attribute :suitable_for_diet, :string
    attribute :recipe_instructions, :stringlist
    attribute :author, :reference

    attribute :calories, :integer
    attribute :fat_content, :integer
    attribute :carbohydrate_content, :integer
    attribute :cholesterol_content, :integer
    attribute :fiber_content, :integer
    attribute :protein_content, :integer
    attribute :saturated_fat_content, :integer
    attribute :serving_size, :integer
    attribute :sodium_content, :integer
    attribute :sugar_content, :integer
    attribute :trans_fat_content, :integer


    def to_json(render_childs = false)
      {
        "@context": "http://schema.org",
        "@type": "Recipe",
        name: name,
        description: description,
        image: image ? image.binary_url : '',
        url: url,
        author: author ? author.to_json : nil,
        prepTime: "PT#{prep_time}M",
        totalTime: "PT#{total_time}M",
        cookTime: "PT#{cook_time}M",
        cookingMethod: cooking_method,
        recipeYield: recipe_yield,
        recipeIngredient: recipe_ingredients.split(','),
        recipeCuisine: recipe_cuisine,
        recipeCategory: recipe_category,
        recipeInstructions: recipe_instructions,
        nutrition: {
          "@context": "http://schema.org",
          "@type": "NutritionInformation",
          calories: "#{calories} calories",
          fatContent: "#{fat_content} g",
          carbohydrateContent: "#{carbohydrate_content} g",
          cholesterolContent: "#{cholesterol_content} mg",
          fiberContent: "#{fiber_content} g",
          proteinContent: "#{protein_content} g",
          saturatedFatContent: "#{saturated_fat_content} g",
          servingSize: "#{serving_size} #{serving_size == 1 ? 'Serving' : 'Servings'}",
          sodiumContent: "#{sodium_content} g",
          sugarContent: "#{sugar_content} g",
          transFatContent: "#{trans_fat_content} g"
        },
        suitableForDiet: {
          "@context": "http://schema.org",
          "@type": "RestrictedDiet",
          description: suitable_for_diet
        }
      }.delete_if { |k, v| !v.present? }
    end
  end
end
