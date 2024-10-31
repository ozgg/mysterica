# frozen_string_literal: true

# Links between dream and personal pattern
#
# Attributes:
#   created_at [DateTime]
#   dream_id [Dream], required
#   personal_pattern_id [PersonalPattern], required
#   updated_at [DateTime]
class DreamPersonalPattern < ApplicationRecord
  belongs_to :dream
  belongs_to :personal_pattern

  validate :owner_matches

  private

  def owner_matches
    return if personal_pattern&.user_id == dream&.user_id

    errors.add(:personal_pattern, :invalid)
  end
end
