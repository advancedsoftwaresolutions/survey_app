require 'application_system_test_case'

class SurveysTest < ApplicationSystemTestCase
  setup do
    @user = User.create!(email: 'test@example.com')
  end

  test 'user creates and views a survey' do
    visit new_survey_path

    fill_in 'Question', with: 'Do you like Rails?'
    click_on 'Create Survey'

    assert_text 'Survey was successfully created.'
    assert_text 'Do you like Rails?'
  end

  test 'user submits a response' do
    survey = Survey.create!(question: 'Is Ruby awesome?', user: @user)

    visit survey_path(survey)

    choose 'Yes' # or use `find('input[value=true]').click` depending on your UI
    click_on 'Submit'

    assert_text 'Response was successfully created'
  end
end
