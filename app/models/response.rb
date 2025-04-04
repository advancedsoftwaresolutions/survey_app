class Response < ApplicationRecord
  # Each response belongs to a specific survey
  belongs_to :survey

  # Validates that the answer must be either true or false
  validates :answer, inclusion: { in: [true, false] }

  # Callback to update survey counters after saving a response
  after_save :update_survey_counters

  # Updates the cached results of the associated survey
  def update_survey_counters
    survey.update_cached_results
  end
end
