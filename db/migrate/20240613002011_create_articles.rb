class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :published, null: false, default: false

      t.timestamps
    end
  end
end
