class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.image_url = CATEGORY_IMAGES.sample

    if @category.save
      redirect_to category_path(@category), notice: "Category was successfully created."
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @recipe = @category.recipes
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, status: :see_other
  end

  private


  def category_params
    params.require(:category).permit(:name, :image_url)
  end
end
