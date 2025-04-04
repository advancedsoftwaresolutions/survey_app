require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_user ||= User.first_or_create!(email: 'test@example.com')
    @survey = @current_user.surveys.create!(question: 'Do you like Rails?')
    @response = @survey.responses.create!(answer: true)
  end

  test 'should create response with valid answer' do
    assert_difference('Response.count') do
      post survey_responses_url(@survey), params: {
        survey_id: @survey.id,
        response: { answer: false }
      }
    end

    assert_redirected_to survey_url(@survey)
    follow_redirect!
    assert_match 'Response was successfully created', response.body
  end

  test 'should not create invalid response' do
    assert_no_difference('Response.count') do
      post survey_responses_url(@survey), params: {
        survey_id: @survey.id,
        response: { answer: nil }
      }
    end

    assert_redirected_to survey_url(@survey)
    follow_redirect!
    assert_match 'Unable to save response', response.body
  end
end
