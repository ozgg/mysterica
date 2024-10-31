# frozen_string_literal: true

FactoryBot.define do
  factory :personal_pattern do
    user
    sequence(:name) { |n| "Pattern #{n}" }
  end
end
