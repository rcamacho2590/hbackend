require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(username: "username", full_name: "Example User", email: "user@example.com")
  end

  test "user should be valid" do
    assert @user.valid?
  end
end
