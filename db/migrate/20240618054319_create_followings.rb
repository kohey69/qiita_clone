class CreateFollowings < ActiveRecord::Migration[7.1]
  def change
    create_table :followings do |t|
      t.references :following_user, null: false, foreign_key: { to_table: :users }, index: false
      t.references :followed_user, null: false, foreign_key: { to_table: :users }
      t.index %i[following_user_id followed_user_id], unique: true

      t.timestamps
    end
  end
end
