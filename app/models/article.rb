class Article < ApplicationRecord
  TAG_MAX_SIZE = 5

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :content, presence: true
  validate :tags_must_be_less_than_or_equal_max_size
  validate :tags_must_be_unique

  scope :default_order, -> { order(created_at: :desc) }
  scope :published, -> { where(published: true) }

  def tag_list
    @tag_list = tags.map(&:name).join(', ')
  end

  def tag_list=(value)
    new_tags = []
    tag_names = value.split(',').map(&:strip)
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name)
      new_tags << tag
    end
    self.tag_ids = new_tags.pluck(:id)
  end

  def tags_must_be_less_than_or_equal_max_size
    if tags.size > TAG_MAX_SIZE
      errors.add(:tag_list, "は#{TAG_MAX_SIZE}個までしか登録できません")
    end
  end

  def tags_must_be_unique
    if tags.uniq.length != tags.length
      errors.add(:tag_list, 'は同じ名前のものは登録できません')
    end
  end
end
