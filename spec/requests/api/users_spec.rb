# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Users' do
  describe 'post /api/join' do
    let(:action) { -> { post '/api/join', params: { user: attributes } } }

    context 'with valid parameters' do
      let(:attributes) do
        { slug: 'user', password: 'secret', password_confirmation: 'secret' }
      end

      it 'responds with Created status' do
        action.call
        expect(response).to have_http_status(:created)
      end

      it 'does not contain errors in response' do
        action.call
        expect(response.parsed_body).not_to have_key('errors')
      end

      it 'creates new user' do
        expect(action).to change(User, :count).by(1)
      end

      it 'responds with access token' do
        action.call
        expected_response = {
          'meta' => { 'access_token' => be_a(String), 'token_type' => 'Bearer' }
        }
        expect(response.parsed_body).to match(expected_response)
      end
    end

    context 'with invalid parameters' do
      let(:attributes) do
        { slug: '--', password: 'a', password_confirmation: 'b' }
      end

      it 'responds with Bad Request status' do
        action.call
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not contain access token in response' do
        action.call
        expect(response.parsed_body.dig('meta', 'access_token')).to be_nil
      end

      it 'does not create new user' do
        expect(action).not_to change(User, :count)
      end

      it 'responds with list of errors' do
        action.call
        expected_response = { 'errors' => ['meta' => be_a(Hash)] }
        expect(response.parsed_body).to match(expected_response)
      end
    end
  end

  describe 'patch /api/me' do
    before do
      patch('/api/me', params: { user: attributes }, headers:)
    end

    let!(:user) { create(:user) }
    let(:token) { JWT.encode({ user_id: user.uuid }, ENV.fetch('JWT_KEY', nil)) }
    let(:headers) { { Authorization: "Bearer #{token}" } }

    context 'when user is not logged in' do
      let(:attributes) { {} }
      let(:headers) { {} }

      it 'responds with Unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when parameters are valid' do
      let(:attributes) do
        { slug: 'user', password: 'secret1', password_confirmation: 'secret1' }
      end

      it 'responds with OK status' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates current user' do
        user.reload
        expect(user.slug).to eq('user')
      end

      it 'renders new data' do # rubocop:disable RSpec/ExampleLength
        expected_response = {
          'data' => {
            'id' => user.uuid,
            'type' => 'User',
            'attributes' => { 'slug' => 'user', 'email' => nil, 'profile' => {} }
          }
        }
        expect(response.parsed_body).to eq(expected_response)
      end
    end

    context 'when parameters are invalid' do
      let(:attributes) do
        { slug: 'user', password: 'a', password_confirmation: 'b' }
      end

      it 'responds with Unprocessable Entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update current user' do
        user.reload
        expect(user.slug).not_to(eq('user'))
      end

      it 'responds with list of errors' do
        expected_response = { 'errors' => ['meta' => be_a(Hash)] }
        expect(response.parsed_body).to match(expected_response)
      end
    end
  end
end
