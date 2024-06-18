class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true

  def favorite?(article)
    self.favorites.find_by(article_id: article.id).present?
  end
end
