json.extract! response, :id, :answer, :survey_id, :created_at, :updated_at
json.url response_url(response, format: :json)
