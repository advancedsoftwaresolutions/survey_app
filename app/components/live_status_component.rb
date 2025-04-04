# frozen_string_literal: true

class LiveStatusComponent < ViewComponent::Base
  def initialize(survey:)
    @survey = survey
  end
end
