class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :description, :location, :views_count, :likes_count, :comments_count, :post_type_id, :file
end
