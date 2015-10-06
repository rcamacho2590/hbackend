class AddPostFileToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_file, :string
  end
end
