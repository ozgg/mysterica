# frozen_string_literal: true

FactoryBot.define do
  factory :dream_pattern do
    sequence(:name) { |i| "Pattern #{i}" }
    summary { 'Some summary' }
    description { 'Longer description of a dream pattern' }
  end
end
