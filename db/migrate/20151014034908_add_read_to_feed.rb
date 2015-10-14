class AddReadToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :read, :boolean, :default => false
  end
end
