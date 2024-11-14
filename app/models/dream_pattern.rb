# frozen_string_literal: true

# Dream pattern (common)
#
# Attributes:
#   description [Text], required
#   created_at [DateTime]
#   name [String], required
#   summary [String]
#   updated_at [DateTime]
#   uuid [UUID], required
class DreamPattern < ApplicationRecord
  include HasUuid

  validates :description, presence: true
  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 50 },
            uniqueness: { case_sensitive: false }
  validates :summary, length: { minimum: 1, maximum: 500 }, allow_blank: true
end
