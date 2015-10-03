class Feed < ActiveRecord::Base
  belongs_to :post
  has_one :user
  has_one :comment
  has_one :like
  
end
