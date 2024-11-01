# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Authentication' do
  let!(:user) { create(:user) }

  shared_examples 'unauthorized request' do
    it 'responds with Unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'shows errors' do
      expect(response.parsed_body).to have_key('errors')
    end

    it 'does not render user info' do
      expect(response.parsed_body).not_to have_key('data')
    end
  end

  context 'when token is not present' do
    describe 'get /api/me' do
      before do
        get '/api/me'
      end

      it_behaves_like 'unauthorized request'
    end
  end

  context 'when token is invalid' do
    let(:headers) { { Authorization: 'Bearer None' } }

    describe 'get /api/me' do
      before do
        get('/api/me', headers:)
      end

      it_behaves_like 'unauthorized request'
    end
  end

  context 'when token is present' do
    let(:token) { JWT.encode({ user_id: user.uuid }, ENV.fetch('JWT_KEY', nil)) }
    let(:headers) { { Authorization: "Bearer #{token}" } }

    describe 'get /api/me' do
      before do
        get('/api/me', headers:)
      end

      it 'responds with OK code' do
        expect(response).to have_http_status(:ok)
      end

      it 'does not contain errors in response' do
        expect(response.parsed_body).not_to have_key(:errors)
      end

      it 'displays user information' do
        expect(response.parsed_body.dig(:data, :id)).to eq(user.uuid)
      end
    end
  end
end
