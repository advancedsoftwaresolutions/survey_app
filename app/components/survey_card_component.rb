class SurveyCardComponent < ViewComponent::Base
  attr_reader :survey, :delay

  def initialize(survey:, delay: 0)
    @survey = survey
    @delay = delay
  end
end
