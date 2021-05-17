class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    return render "new" unless @category.save

    flash[:notice] = "Category was created successfully"
    redirect_to @category
  end

  def index

  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end