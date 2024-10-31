# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DreamInterpretation do
  before do
    create(:dream_interpretation)
  end

  it_behaves_like 'has_uuid'

  it { is_expected.to belong_to(:dream) }
  it { is_expected.to belong_to(:user) }

  describe 'validation' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(20).is_at_most(50_000) }
  end
end
