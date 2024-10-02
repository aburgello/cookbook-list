class AddMealIdToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :meal_id, :string
  end
end
