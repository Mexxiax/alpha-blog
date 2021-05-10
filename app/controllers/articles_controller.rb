class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all
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
    @article.user = User.first
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
end
