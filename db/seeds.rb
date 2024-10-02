# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'

# Clear existing records
Bookmark.destroy_all
Category.destroy_all
Recipe.destroy_all

CATEGORY_IMAGES =
[
"https://plus.unsplash.com/premium_photo-1669150852127-2435412047f2?q=80&w=2017&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://images.unsplash.com/photo-1503011994592-d30eb1ef61dc?q=80&w=2006&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://plus.unsplash.com/premium_photo-1699976106749-6639d0986e9b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://plus.unsplash.com/premium_photo-1679434184867-a294eb85400c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://plus.unsplash.com/premium_photo-1672363353881-68c8ff594e25?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://plus.unsplash.com/premium_photo-1678897742200-85f052d33a71?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://images.unsplash.com/photo-1478998674531-cb7d22e769df?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://plus.unsplash.com/premium_photo-1700746099630-66c656bf8236?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://images.unsplash.com/photo-1495480137269-ff29bd0a695c?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://plus.unsplash.com/premium_photo-1671403964040-3fa56d33f44b?q=80&w=2002&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
"https://plus.unsplash.com/premium_photo-1673108852141-e8c3c22a4a22?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

service = TheMealDbService.new
response = service.list_categories

if response.success?
  categories = response.parsed_response["categories"]

  categories.each do |cat|
    category_name = cat["strCategory"]
    category = Category.find_or_create_by(name: category_name) do |c|
    c.image_url = CATEGORY_IMAGES.sample
    end
    puts "Seeded Category: #{category_name}"

    meals_response = service.meals_by_category(category_name)

    if meals_response.success?
      meals = meals_response.parsed_response["meals"]

      meals.each do |meal|
        meal_detail_response = service.meal_details(meal["idMeal"])

        if meal_detail_response.success?
          meal_details = meal_detail_response.parsed_response["meals"].first

          recipe = Recipe.find_or_initialize_by(meal_id: meal_details["idMeal"])
          recipe.name = meal_details["strMeal"]
          recipe.description = meal_details["strInstructions"]
          recipe.image_url = meal_details["strMealThumb"]
          recipe.rating = rand(7.0..10.0).round(1)

          if recipe.save
            # Create a bookmark to link the recipe and category
            Bookmark.create!(recipe: recipe, category: category, comment: "Delicious recipe!")
            puts "Seeded Recipe: #{recipe.name}"
          else
            puts "Failed to seed Recipe: #{recipe.name} - Errors: #{recipe.errors.full_messages.join(", ")}"
          end
        else
          puts "Failed to fetch details for meal ID: #{meal['idMeal']}"
        end
      end
    else
      puts "Failed to fetch meals for category: #{category_name}"
    end
  end

  puts "Seeding recipes completed successfully!"
end
