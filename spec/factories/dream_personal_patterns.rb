# frozen_string_literal: true

FactoryBot.define do
  factory :dream_personal_pattern do
    transient do
      user { association(:user) }
    end

    dream { association(:dream, user:) }
    personal_pattern { association(:personal_pattern, user:) }
  end
end
