class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
