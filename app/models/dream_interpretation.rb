# frozen_string_literal: true

# Dream interpretation
#
# Attributes:
#   body [text], required
#   created_at [DateTime]
#   dream_id [Dream], required
#   updated_at [DateTime]
#   user_id [User], required
#   uuid [uuid], required
class DreamInterpretation < ApplicationRecord
  include HasUuid

  belongs_to :dream
  belongs_to :user

  validates :body, presence: true, length: { minimum: 20, maximum: 50_000 }
end
