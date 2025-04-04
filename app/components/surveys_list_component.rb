# frozen_string_literal: true

class SurveysListComponent < ViewComponent::Base
  def initialize(surveys:)
    @surveys = surveys
  end
end
