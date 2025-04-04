# app/components/survey_response_summary_component.rb
class SurveyResponseSummaryComponent < ViewComponent::Base
  def initialize(survey:)
    @survey = survey
  end

  def last_response_time_text
    if @survey.last_response_time.present?
      "Last responded #{ActionController::Base.helpers.time_ago_in_words(@survey.last_response_time)} ago"
    else
      'No responses yet'
    end
  end
end
