require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'user with a valid email should be valid' do
    user = User.new(email: "test@example.com", password_digest: "test123456")
    assert user.valid?
  end

  test 'user with invalid email should not be valid' do 
    user = User.new(email: 'test', password_digest: "test123456")
    assert_not user.valid?
  end

   test 'user with existing email should not be valid' do 
    existing_user = users(:one)
    user = User.new(email: existing_user.email, password_digest: "test123456")
    assert_not user.valid?
  end
end
