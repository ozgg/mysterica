# frozen_string_literal: true

# Dream
#
# Attributes:
#   body [text], required
#   created_at [DateTime]
#   deleted_at [DateTime]
#   lucidity [integer], required
#   privacy [integer], required
#   sleep_place_id [SleepPlace]
#   title [string]
#   uuid [uuid], required
#   user_id [User]
#   updated_at [DateTime]
class Dream < ApplicationRecord
  include HasUuid

  belongs_to :user, optional: true
  belongs_to :sleep_place, optional: true
  has_many :dream_interpretations, dependent: :delete_all
  has_many :dream_personal_patterns, dependent: :delete_all
  has_many :personal_patterns, through: :dream_personal_patterns

  enum :privacy, { generally_accessible: 0, for_community: 1, personal: 2 }

  validates :body, presence: true, length: { minimum: 20, maximum: 50_000 }
  validates :lucidity, presence: true, numericality: { in: (0..5) }
  validates :privacy, presence: true
  validates :title, length: { maximum: 200 }
  validate :sleep_place_should_match_owner

  private

  def sleep_place_should_match_owner
    return if sleep_place.nil?
    return if sleep_place.user_id == user_id

    errors.add(:sleep_place, :invalid)
  end
end
