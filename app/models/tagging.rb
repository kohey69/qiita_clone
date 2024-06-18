class Tagging < ApplicationRecord
  belongs_to :article
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :article }
end
