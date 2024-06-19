class ArticlesController < ApplicationController
  def index
    @articles = Article.published.with_tags(params[:tag_names]).default_order.page(params[:page])
  end

  def show
    @article = Article.published.find(params[:id])
  end
end
