# frozen_string_literal: true

# Sleep place where dreams are seen
#
# Attributes:
#   created_at [DateTime]
#   name [String], required
#   updated_at [DateTime]
#   user_id [User], required
#   uuid [UUID], required
class SleepPlace < ApplicationRecord
  include HasUuid

  belongs_to :user
  has_many :dreams, dependent: :nullify

  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 100 },
            uniqueness: { scope: :user_id }
end
