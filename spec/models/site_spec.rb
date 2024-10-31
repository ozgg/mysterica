# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Site do
  before do
    create(:site)
  end

  it_behaves_like 'has_uuid'
  it_behaves_like 'has_required_boolean_attribute', :active

  describe 'validation' do
    it { is_expected.to have_secure_token }
    it { is_expected.to have_many(:users) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_length_of(:slug).is_at_least(4).is_at_most(100) }
    it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
  end
end
