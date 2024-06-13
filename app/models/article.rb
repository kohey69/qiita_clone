class Article < ApplicationRecord
  TAG_MAX_SIZE = 5
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :content, presence: true
  validate :tags_must_be_less_than_or_equal_max_size

  def tags_must_be_less_than_or_equal_max_size
    if tags.size > TAG_MAX_SIZE
      errors.add(:tags, "は#{TAG_MAX_SIZE}個までしか登録できません。")
    end
  end

  scope :default_order, -> { order(created_at: :desc) }
  scope :published, -> { where(published: true) }
end
