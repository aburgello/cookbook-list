class TheMealDbService
  include HTTParty
  base_uri "https://www.themealdb.com/api/json/v1/1"

  def list_categories
    self.class.get("/categories.php")
  end

  def meals_by_category(category)
    self.class.get("/filter.php", query: { c: category })
  end

  def meal_details(meal_id)
    self.class.get("/lookup.php", query: { i: meal_id })
  end
end
