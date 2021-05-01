class ArticlesController < ApplicationController

    def index
        @articles = Article.all
    end


    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new #para carregar na criação de artigos
    end

    def create
        #render plain: params[:article]
        @article = Article.new(params.require(:article).permit(:title, :description))
        #render plain: @article.inspect
        return render 'new' unless @article.save

        flash[:notice] = "Article was created successfully"
        redirect_to @article
    end

end