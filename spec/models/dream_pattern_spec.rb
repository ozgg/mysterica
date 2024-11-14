# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DreamPattern do
  before do
    create(:dream_pattern)
  end

  it_behaves_like 'has_uuid'

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_length_of(:summary).is_at_least(1).is_at_most(500).allow_blank }
    it { is_expected.to validate_presence_of(:description) }
  end
end
