class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.published.default_order.page(params[:page])
    @favorite_articles = @user.favorite_articles.published.default_order.page(params[:favorites_page])
  end
end
