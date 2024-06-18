class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :articles, through: :taggings

  validates :name, presence: true, uniqueness: true # 大文字小文字を区別するのでcase_sensitiveはつけない
end
