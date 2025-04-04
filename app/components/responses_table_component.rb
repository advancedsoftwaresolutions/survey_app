# frozen_string_literal: true

class ResponsesTableComponent < ViewComponent::Base
  def initialize(survey:)
    @survey = survey
  end
end
