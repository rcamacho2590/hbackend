class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.string :description
      t.integer :comment_id
      t.integer :like_id

      t.timestamps
    end
  end
end
