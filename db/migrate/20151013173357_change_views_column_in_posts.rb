class ChangeViewsColumnInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :views, :views_count
  end
end
