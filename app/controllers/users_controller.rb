class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.published.default_order.page(params[:page])
    @favorite_articles = Article.published.with_favorites(@user).default_order.page(params[:favorites_age])
  end
end
