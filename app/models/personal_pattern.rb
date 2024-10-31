# frozen_string_literal: true

# Personal dream pattern
#
# Attributes:
#   created_at [DateTime]
#   name [String], required
#   updated_at [DateTime]
#   user_id [User], required
#   uuid [UUID], required
class PersonalPattern < ApplicationRecord
  include HasUuid

  belongs_to :user

  has_many :dream_personal_patterns, dependent: :delete_all
  has_many :dreams, through: :dream_personal_patterns

  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 100 },
            uniqueness: { scope: :user_id }
end
