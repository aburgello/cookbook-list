# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Bookmark.destroy_all
Category.destroy_all
Recipe.destroy_all

recipes = [
  { name: "Spaghetti Carbonara", description: "A classic Italian pasta dish with egg and guanciale.", image_url: "https://tynerpondfarm.com/wp-content/uploads/2023/01/pasta-carbonara-with-jowl-bacon.jpg.webp", rating: 9.5 },
  { name: "Caesar Salad", description: "A refreshing salad with romaine lettuce, croutons, and Parmesan cheese.", image_url: "https://www.grocery.coop/sites/default/files/NCG_Dennis_Becker_Classic_Caesar_Salad_715_x_477.jpg", rating: 7.0 },
  { name: "Pancakes", description: "Fluffy pancakes perfect for breakfast or brunch.", image_url: "https://www.inspiredtaste.net/wp-content/uploads/2024/03/Easy-Fluffy-Pancakes-Recipe-Video.jpg", rating: 7.8 },
  { name: "Pizza Margherita", description: "A delicious pizza with tomato sauce, mozzarella cheese, and fresh basil.", image_url: "https://images.prismic.io/eataly-us/ed3fcec7-7994-426d-a5e4-a24be5a95afd_pizza-recipe-main.jpg", rating: 8.5 },
  { name: "Chicken Tikka Masala", description: "A creamy Indian dish with marinated chicken in a spiced tomato sauce.", image_url: "https://www.shemins.com/wp-content/uploads/2017/03/shemins-chicken-tikka-masala-LR-1280x1280.jpg", rating: 8.2 },
  { name: "Sushi", description: "Japanese dish of vinegared rice with various toppings, like fish and vegetables.", image_url: "https://offloadmedia.feverup.com/secretldn.com/wp-content/uploads/2015/06/25142802/shutterstock_1470615731-2.jpg", rating: 9.0 },
  { name: "Tacos", description: "Mexican dish with corn tortillas filled with various ingredients like meat, vegetables, and salsa.", image_url: "https://feelgoodfoodie.net/wp-content/uploads/2024/04/Ground-Beef-Tacos-TIMG.jpg", rating: 8.0 },
  { name: "Tom Yum Soup", description: "A spicy and sour Thai soup with shrimp, lemongrass, and kaffir lime leaves.", image_url: "https://hot-thai-kitchen.com/wp-content/uploads/2013/03/tom-yum-goong-blog.jpg", rating: 8.7 },
  { name: "Beef Stroganoff", description: "A classic Russian dish with tender beef in a creamy mushroom sauce.", image_url: "https://messinthekitchen.com/wp-content/uploads/2021/04/beef-stroganoff-feature.jpg", rating: 8.5 },
  { name: "Chicken Parmesan", description: "A breaded and baked chicken breast topped with marinara sauce and mozzarella cheese.", image_url: "https://thecozycook.com/wp-content/uploads/2022/08/Chicken-Parmesan-Recipe-f-500x500.jpg", rating: 8.0 },
  { name: "Lasagna", description: "A stacked layers of lasagna alternating with fillings such as ragù, béchamel sauce, vegetables, cheeses, and seasonings and spices.", image_url: "https://www.modernhoney.com/wp-content/uploads/2019/08/Classic-Lasagna-14-scaled.jpg", rating: 9.0 },
  { name: "Shrimp Scampi", description: "Garlic-infused shrimp sautéed in white wine and butter.", image_url: "https://static01.nyt.com/images/2022/06/02/dining/ShrimpScampi_thumb/ShrimpScampi_thumb-square640.jpg", rating: 8.5 },
  { name: "Pad Thai", description: "A stir-fried noodle dish with shrimp, vegetables, and a tangy tamarind sauce.", image_url: "https://www.foodandwine.com/thmb/9Vb8WuiTba45J_7HEXV6M58bo2U=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Shrimp-Pad-Thai-FT-RECIPE0324-3132ca704bc0457e836127dbda403368.jpg", rating: 8.8 }
]

recipes.each do |recipe|
  Recipe.create!(recipe)
end

