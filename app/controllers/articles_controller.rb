class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def new
    @article = Article.new #para carregar na criação de artigos
  end

  def edit; end

  def create
    #render plain: params[:article]
    #render plain: @article.inspect
    @article = Article.new(article_params)
    @article.user = current_user
    return render "new" unless @article.save

    flash[:notice] = "Article was created successfully"
    redirect_to @article
  end

  def update
    return render "edit" unless @article.update(article_params)

    flash[:notice] = "Article was edited successfully"
    redirect_to @article
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:alert] = "You can only delete or edit your own article"
      redirect_to @article
    end
  end

end
