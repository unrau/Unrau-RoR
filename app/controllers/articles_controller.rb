class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :edit, :create, :update, :destroy]
  #before_action :correct_user, only: [:edit, :update, :destroy]
  # the correct_user method clashes with the FriendlyID slug, so I've removed the requirement
  # for the correct user to edit articles. I'm still the only user, so I'm just adding an admin
  # requirement below.
  before_action :admin_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], :per_page => 30)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
end
