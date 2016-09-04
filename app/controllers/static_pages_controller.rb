class StaticPagesController < ApplicationController

  def home
    @articles = Article.paginate(page: params[:page], :per_page => 5)
  end

  def wallpapers
  end

  def fiasco
  end

end
