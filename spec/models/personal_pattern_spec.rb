# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PersonalPattern do
  before do
    create(:personal_pattern)
  end

  it_behaves_like 'has_uuid'

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:dream_personal_patterns) }
  it { is_expected.to have_many(:dreams).through(:dream_personal_patterns) }

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(100) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
  end
end
