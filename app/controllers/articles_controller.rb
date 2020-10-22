class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @articles = Article.all
    @comment = Comment.new
    @comment.article_id = @article_id
  end

  def new
    @article = Article.new
    @articles = Article.all
  end

  def edit
    @articles = Article.all
  end

  def create
    @article = Article.new(article_params)
    @article.original = params[:article][:body]
    author_list = article_params[:signature]
    @article.author_list += ", " + author_list
    
    @articles = Article.all

    if @article.title == '' || @article.body == '' || @article.signature == ''
      flash.now.notice = "All fields must contain text!"
      render :new
      return
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article}
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @articles = Article.all
    
    if params[:article][:title] == '' || params[:article][:body] == '' || params[:article][:signature] == ''
      flash.now.notice = "All fields must contain text!"
      render :edit
      return
    end

    author_list = article_params[:signature]
    @article.author_list += ", " + author_list

    origin = Article.find(params[:id])
    params[:article][:signature] = origin.signature
    @article.update(article_params)

    redirect_to @article
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_path }
      format.json { head :no_content }
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :signature, :author_list)
    end
end
