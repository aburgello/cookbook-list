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

Bookmark.destroy_all
Category.destroy_all
Recipe.destroy_all

service = TheMealDbService.new
response = service.list_categories


if response.success?
  categories = response.parsed_response["categories"]

  categories.each do |cat|
    Category.find_or_create_by(name: cat["strCategory"]) do |category|
      category.image_url = cat["strCategoryThumb"]
    end
    puts "Seeded Category: #{cat['strCategory']}"
  end

  puts "Seeding completed successfully!"
else
  puts "Failed to fetch categories from TheMealDB."
end


if response.success?
  categories = response.parsed_response["categories"]

  categories.each do |cat|
    category_name = cat["strCategory"]
    puts "Fetching meals for category: #{category_name}"

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

          recipe.rating = rand(7.0..10.0).round(10)

          if recipe.save
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
