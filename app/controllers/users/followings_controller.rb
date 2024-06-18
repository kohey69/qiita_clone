class Users::FollowingsController < Users::ApplicationController
  def index
    @following_users = @user.following_users.with_attached_avatar.page(params[:following_page])
    @followed_users = @user.followed_users.with_attached_avatar.page(params[:followed_page])
  end

  def create
    current_user.active_followings.find_or_create_by!(followed_user: @user)
  end

  def destroy
    following = current_user.active_followings.find_by(followed_user: @user)
    following&.destroy!
  end
end
