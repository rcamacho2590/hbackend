class FeedSerializer < ActiveModel::Serializer
  attributes :id, :post_id, :user_id, :description, :comment_id, :like_id
end
