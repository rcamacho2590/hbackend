class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :description
      t.integer :user_id
      t.string :location
      t.integer :post_type_id
      t.integer :views

      t.timestamps
    end
  end
end
