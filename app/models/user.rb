# frozen_string_literal: true

# User
#
# Attributes:
#   active [Boolean], required
#   bot [Boolean], required
#   created_at [DateTime]
#   deleted_at [DateTime]
#   email [String]
#   email_confirmed [Boolean], required
#   inviter_id [User]
#   notice [String]
#   password_digest [String], required
#   profile [JSON], required
#   referral_code [String]
#   site [Site]
#   slug [String], required
#   super_user [Boolean], required
#   updated_at [DateTime]
#   uuid [UUID], required
class User < ApplicationRecord
  include HasUuid

  has_secure_password

  attribute :referral_code, default: -> { SecureRandom.alphanumeric(16) }

  belongs_to :inviter, class_name: 'User', optional: true
  belongs_to :site, optional: true
  has_many :invitees,
           class_name: 'User',
           foreign_key: :inviter_id,
           dependent: :nullify,
           inverse_of: :inviter

  validates :active, inclusion: { in: [true, false] }
  validates :bot, inclusion: { in: [true, false] }
  validates :email,
            uniqueness: { case_sensitive: false },
            allow_nil: true,
            format: URI::MailTo::EMAIL_REGEXP,
            length: { maximum: 200 }
  validates :email_confirmed, inclusion: { in: [true, false] }
  validates :profile, hash_field: true
  validates :referral_code,
            uniqueness: true,
            length: { minimum: 1, maximum: 16 },
            allow_nil: true
  validates :slug,
            uniqueness: { case_sensitive: false },
            format: /\A[_a-z0-9]+\z/i,
            length: { minimum: 1, maximum: 24 }
  validates :super_user, inclusion: { in: [true, false] }
end
