class RecipesController < ApplicationController
  def index
    if params[:category_id]
      @recipes = Recipe.where(category_id: params[:category_id])
    else
      @recipes = Recipe.all
    end
  end
end
