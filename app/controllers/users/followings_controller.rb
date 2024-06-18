class Users::FollowingsController < Users::ApplicationController
  def create
    current_user.active_followings.find_or_create_by!(followed_user: @user)
  end

  def destroy
    following = current_user.active_followings.find_by(followed_user: @user)
    following&.destroy!
  end
end
