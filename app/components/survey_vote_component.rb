# app/components/survey_vote_component.rb
class SurveyVoteComponent < ViewComponent::Base
  def initialize(survey:)
    @survey = survey
  end
end
