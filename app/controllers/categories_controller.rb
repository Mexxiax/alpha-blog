class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

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
    @articles = @category.articles.paginate(page: params[:page], per_page: 5).order("id DESC")
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?) 
      flash[:alert] = "Only admins can perfform that action"
      redirect_to categories_path
    end
  end
end