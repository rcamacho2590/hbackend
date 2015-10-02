class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :description
      t.integer :comment_id
      t.integer :like_id

      t.timestamps
    end
  end
end
