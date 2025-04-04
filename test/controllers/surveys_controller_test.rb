require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_user ||= User.first_or_create!(email: 'test@example.com')
    @survey = @current_user.surveys.create!(question: 'Is Ruby awesome?')
  end

  test 'should get index' do
    get surveys_url
    assert_response :success
  end

  test 'should show survey with chart data' do
    @survey.responses.create!(answer: true)
    @survey.responses.create!(answer: false)
    get survey_url(@survey)
    assert_response :success
    assert_select 'body', /Yes/
    assert_select 'body', /No/
  end

  test 'should get new' do
    get new_survey_url
    assert_response :success
  end

  test 'should create survey' do
    assert_difference('Survey.count') do
      post surveys_url, params: {
        survey: { question: 'Is Minitest fast?' }
      }
    end
    assert_redirected_to survey_path(Survey.last)
    follow_redirect!
    assert_match 'Survey was successfully created', response.body
  end

  test 'should not create invalid survey' do
    assert_no_difference('Survey.count') do
      post surveys_url, params: {
        survey: { question: '' } # invalid
      }
    end
    assert_response 422
  end

  test 'should get edit' do
    get edit_survey_url(@survey)
    assert_response :success
  end

  test 'should update survey' do
    patch survey_url(@survey), params: {
      survey: { question: 'Updated Question?' }
    }
    assert_redirected_to survey_url(@survey)
    follow_redirect!
    assert_match 'Survey was successfully updated', response.body
  end

  test 'should not update with invalid data' do
    patch survey_url(@survey), params: {
      survey: { question: '' }
    }
    assert_response 422
  end

  test 'should destroy survey' do
    assert_difference('Survey.count', -1) do
      delete survey_url(@survey)
    end
    assert_redirected_to surveys_url
  end
end
