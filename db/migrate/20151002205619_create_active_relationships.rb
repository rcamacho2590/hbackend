class CreateActiveRelationships < ActiveRecord::Migration
  def change
    create_table :active_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :active_relationships, :follower_id
    add_index :active_relationships, :followed_id
    add_index :active_relationships, [:follower_id, :followed_id], unique: true
  end
end
