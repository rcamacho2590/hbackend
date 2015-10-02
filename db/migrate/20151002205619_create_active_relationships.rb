class CreateActiveRelationships < ActiveRecord::Migration
  def change
    create_table :active_relationships do |t|
      t.integer :following_id
      t.integer :followed_id

      t.timestamps
    end
  end
end
