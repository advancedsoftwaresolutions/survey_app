# app/components/survey_form_component.rb
class SurveyFormComponent < ViewComponent::Base
  def initialize(survey:)
    @survey = survey
  end
end
