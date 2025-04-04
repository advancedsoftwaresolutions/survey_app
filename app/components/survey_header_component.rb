# frozen_string_literal: true

class SurveyHeaderComponent < ViewComponent::Base
  def initialize(count: 0)
    @count = count
  end
end
