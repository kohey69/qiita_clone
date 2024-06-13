class Article < ApplicationRecord
  TAG_MAX_SIZE = 5

  attr_writer :tag_list

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :content, presence: true
  validate :tags_must_be_less_than_or_equal_max_size

  scope :default_order, -> { order(created_at: :desc) }
  scope :published, -> { where(published: true) }

  def tag_list
    @tag_list ||= tags.map(&:name).join(', ')
  end

  def tags_must_be_less_than_or_equal_max_size
    if tag_list.size > TAG_MAX_SIZE
      errors.add(:tag_list, "は#{TAG_MAX_SIZE}個までしか登録できません。")
    end
  end

  def update_with_tags!(params)
    transaction do
      self.taggings.destroy_all
      tag_names = params[:tag_list].split(',').map(&:strip)
      tag_names.each do |tag_name|
        tag = Tag.find_or_initialize_by(name: tag_name)
        self.tags << tag
      end
      self.update!(params)
    end
  end

  def self.build_with_tags(params)
    article = self.build(params)
    tag_names = params[:tag_list].split(',').map(&:strip)
    tag_names.each do |tag_name|
      tag = Tag.find_or_initialize_by(name: tag_name)
      article.tags << tag
    end
    article
  end
end
