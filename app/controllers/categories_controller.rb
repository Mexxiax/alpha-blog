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
    @categories = Category.paginate(page: params[:page], per_page: 5).order("id DESC")
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end