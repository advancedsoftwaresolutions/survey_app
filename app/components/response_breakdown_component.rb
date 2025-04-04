# app/components/response_breakdown_component.rb
class ResponseBreakdownComponent < ViewComponent::Base
  def initialize(survey:)
    @survey = survey
  end

  def yes_percentage
    @survey.yes_percentage || 0
  end

  def no_percentage
    @survey.no_percentage || 0
  end

  def total_responses
    @survey.total_responses || 0
  end

  def last_response_time
    @survey.last_response_time
  end
end
