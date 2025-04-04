require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: 'test@example.com')
    @survey = Survey.create!(question: 'Is Ruby awesome?', user: @user)
  end

  test 'is valid with valid attributes' do
    assert @survey.valid?
  end

  test 'is invalid without a question' do
    @survey.question = nil
    assert_not @survey.valid?
    assert_includes @survey.errors[:question], "can't be blank"
  end

  test 'belongs to a user' do
    assert_equal @user, @survey.user
  end

  test 'has many responses' do
    @survey.responses.create!(answer: true)
    @survey.responses.create!(answer: false)
    assert_equal 2, @survey.responses.count
  end

  test '#last_response_time returns the latest response timestamp' do
    early = @survey.responses.create!(answer: true, created_at: 1.hour.ago)
    late = @survey.responses.create!(answer: false, created_at: Time.current)
    assert_equal late.created_at.to_i, @survey.last_response_time.to_i
  end

  test '#yes_count returns the number of yes answers' do
    3.times { @survey.responses.create!(answer: true) }
    2.times { @survey.responses.create!(answer: false) }
    assert_equal 3, @survey.yes_count
  end

  test '#no_count returns the number of no answers' do
    1.times { @survey.responses.create!(answer: true) }
    4.times { @survey.responses.create!(answer: false) }
    assert_equal 4, @survey.no_count
  end

  test '#total_responses returns total number of responses' do
    5.times { @survey.responses.create!(answer: [true, false].sample) }
    assert_equal 5, @survey.total_responses
  end

  test '#yes_percentage returns 0 when there are no responses' do
    assert_equal 0, @survey.yes_percentage
  end

  test '#yes_percentage calculates correct value' do
    3.times { @survey.responses.create!(answer: true) }
    1.times { @survey.responses.create!(answer: false) }
    assert_equal 75.0, @survey.yes_percentage
  end

  test '#no_percentage complements yes_percentage to 100' do
    1.times { @survey.responses.create!(answer: true) }
    3.times { @survey.responses.create!(answer: false) }
    assert_equal 25.0, @survey.yes_percentage
    assert_equal 75.0, @survey.no_percentage
  end
end
