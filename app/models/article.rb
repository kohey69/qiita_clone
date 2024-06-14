class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  scope :default_order, -> { order(created_at: :desc, id: :desc) }
end
