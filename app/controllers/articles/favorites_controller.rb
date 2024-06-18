class Articles::FavoritesController < Articles::ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorites.find_or_create_by!(article: @article) # いいね済みの場合は例外を吐かないように
  end

  def destroy
    @favorite = current_user.favorites.find_by(article: @article)
    @favorite&.destroy # windowを複数開いていいねを解除した時に例外を吐かないように
  end
end
