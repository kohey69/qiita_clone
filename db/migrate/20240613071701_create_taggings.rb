class CreateTaggings < ActiveRecord::Migration[7.1]
  def change
    create_table :taggings do |t|
      t.references :article, null: false, foreign_key: true, index: false
      t.references :tag, null: false, foreign_key: true

      t.index %i[article_id tag_id], unique: true
      t.timestamps
    end
  end
end
