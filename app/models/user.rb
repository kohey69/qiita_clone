class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :active_followings, dependent: :destroy, class_name: 'Following', foreign_key: 'following_user_id', inverse_of: :following_user
  has_many :passive_followings, dependent: :destroy, class_name: 'Following', foreign_key: 'followed_user_id', inverse_of: :followed_user
  has_many :following_users, through: :active_followings, source: :followed_user
  has_many :followed_users, through: :passive_followings, source: :following_user

  validates :name, presence: true

  def favorite?(article)
    self.favorites.find_by(article_id: article.id).present?
  end
end
