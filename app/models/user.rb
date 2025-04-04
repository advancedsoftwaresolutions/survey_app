class User < ApplicationRecord
  # A user can have many surveys. Deleting a user will also delete all their associated surveys.
  has_many :surveys, dependent: :destroy
end
