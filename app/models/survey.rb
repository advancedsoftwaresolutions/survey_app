class Survey < ApplicationRecord
  # A survey belongs to a user and has many responses. Deleting a survey will also delete its responses.
  belongs_to :user
  has_many :responses, dependent: :destroy

  # Ensures that a survey must have a question before it can be saved.
  validates :question, presence: true

  # Updates cached results for the survey, calculating percentages and total responses.
  def update_cached_results
    total = responses.count.to_f # Total number of responses (converted to float for division).
    yes = responses.where(answer: 'yes').count # Count of 'yes' responses.
    no = responses.where(answer: 'no').count # Count of 'no' responses.

    # Updates the survey with calculated percentages and total responses.
    update(
      yes_percent: (yes / total * 100).round, # Percentage of 'yes' responses.
      no_percent: (no / total * 100).round, # Percentage of 'no' responses.
      responses_count: total.to_i # Total number of responses as an integer.
    )
  end

  # Returns a hash of the result percentages for 'yes' and 'no' responses.
  def result_percentages
    {
      yes: yes_percent || 0, # Default to 0 if yes_percent is nil.
      no: no_percent || 0 # Default to 0 if no_percent is nil.
    }
  end

  # Returns the timestamp of the most recent response.
  def last_response_time
    responses.maximum(:created_at)
  end

  # Returns the count of responses with a 'yes' answer.
  def yes_count
    responses.where(answer: true).count
  end

  # Returns the count of responses with a 'no' answer.
  def no_count
    responses.where(answer: false).count
  end

  # Returns the total number of responses for the survey.
  def total_responses
    responses.count
  end

  # Calculates and returns the percentage of 'yes' responses.
  def yes_percentage
    return 0 if total_responses.zero? # Avoid division by zero.

    ((yes_count.to_f / total_responses) * 100).round(1) # Rounded to 1 decimal place.
  end

  # Calculates and returns the percentage of 'no' responses.
  def no_percentage
    100 - yes_percentage # Complement of the 'yes' percentage.
  end
end
