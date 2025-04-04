# test/components/survey_card_component_test.rb
require 'test_helper'

class SurveyCardComponentTest < ViewComponent::TestCase
  def test_renders_survey_question
    survey = Survey.new(id: 1, question: 'Testing survey')
    render_inline(SurveyCardComponent.new(survey: survey))

    assert_text 'Survey Question: Testing survey'
  end
end
