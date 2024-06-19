class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :article, null: false, foreign_key: true
      t.index %i[user_id article_id], unique: true
      t.timestamps
    end
  end
end
