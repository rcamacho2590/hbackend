class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :description, :location, :views, :post_type_id, :file
end
