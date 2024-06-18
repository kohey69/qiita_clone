class Articles::ApplicationController < ApplicationController
  before_action :set_article

  private

  def set_article
    @article = Article.published.find(params[:article_id])
  end
end
