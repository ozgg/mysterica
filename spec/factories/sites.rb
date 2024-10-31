# frozen_string_literal: true

FactoryBot.define do
  factory :site do
    sequence(:slug) { |n| "https://#{n}.example.com" }
  end
end
