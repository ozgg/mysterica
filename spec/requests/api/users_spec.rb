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
end
