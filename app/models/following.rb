class Following < ApplicationRecord
  belongs_to :following_user, class_name: 'User', inverse_of: :active_followings
  belongs_to :followed_user, class_name: 'User', inverse_of: :passive_followings

  validates :following_user_id, uniqueness: { scope: :followed_user_id }
end
