require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: 'test@example.com')
    @survey = @user.surveys.create!(question: 'Is Ruby awesome?')
  end

  test 'valid with true answer' do
    response = Response.new(answer: true, survey: @survey)
    assert response.valid?
  end

  test 'valid with false answer' do
    response = Response.new(answer: false, survey: @survey)
    assert response.valid?
  end

  test 'invalid without answer' do
    response = Response.new(survey: @survey)
    assert_not response.valid?
    assert_includes response.errors[:answer], 'is not included in the list'
  end

  test 'invalid without survey' do
    response = Response.new(answer: true)
    assert_not response.valid?
    assert_includes response.errors[:survey], 'must exist'
  end
end
