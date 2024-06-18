class Articles::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: %i[destroy]

  def create
    @favorite = current_user.favorites.build(favorite_params)
    @favorite.save
  end

  def destroy
    @favorite = current_user.favorites.find_by(article_id: favorite_params[:article_id])
    @favorite&.destroy # windowを複数開いていいねを解除した時に例外を吐かないように
  end

  private

  def favorite_params
    params.require(:favorite).permit(:article_id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
