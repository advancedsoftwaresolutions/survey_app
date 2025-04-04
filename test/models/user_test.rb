require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: 'user@example.com')
  end

  test 'is valid with valid attributes' do
    assert @user.valid?
  end

  test 'has many surveys' do
    @user.surveys.create!(question: 'Question 1')
    @user.surveys.create!(question: 'Question 2')

    assert_equal 2, @user.surveys.count
  end

  test 'deletes associated surveys when user is destroyed' do
    @user.surveys.create!(question: 'Should be deleted')
    assert_difference('Survey.count', -1) do
      @user.destroy
    end
  end
end
