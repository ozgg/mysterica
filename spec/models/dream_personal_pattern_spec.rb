# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DreamPersonalPattern do
  it { is_expected.to belong_to(:dream) }
  it { is_expected.to belong_to(:personal_pattern) }

  context 'when dream and pattern owners are different' do
    let(:personal_pattern) { create(:personal_pattern) }
    let(:dream_personal_pattern) { build(:dream_personal_pattern, personal_pattern:) }

    it 'does not pass validation', :aggregate_failures do
      expect(dream_personal_pattern).not_to be_valid
      expect(dream_personal_pattern.errors.messages).to have_key(:personal_pattern)
    end
  end
end
