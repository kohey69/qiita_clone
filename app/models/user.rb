class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  validates :name, presence: true
end
