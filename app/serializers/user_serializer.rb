class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :full_name, :email, :authentication_token

end
