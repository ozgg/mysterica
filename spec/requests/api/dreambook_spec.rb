# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Dreambook' do
  before do
    create(:dream_pattern, name: 'Арбуз', summary: 'Про арбуз', description: 'Подробнее про арбуз')
    create(:dream_pattern, name: 'Банан', summary: 'Про банан')
    create(:dream_pattern, name: 'Вода', summary: 'Про воду')
    create(:dream_pattern, name: 'Веник', summary: 'Про веник')
  end

  describe 'get /api/dreambook' do
    before do
      get '/api/dreambook'
    end

    it 'returns list of letters with links' do
      chunk = {
        'type' => 'DreambookLetter', 'id' => 'А',
        'links' => { 'self' => api_dreambook_letter_path(letter: 'А') }
      }

      expect(response.parsed_body['data'][0]).to eq(chunk)
    end
  end

  describe 'get /api/dreambook/:letter' do
    context 'when patterns starting with this letter present' do
      before do
        # /api/dreambook/В
        get '/api/dreambook/%D0%92'
      end

      it 'returns list of patterns starting with given letter with summary' do # rubocop:disable RSpec/ExampleLength
        expected_response = {
          'data' => [
            {
              'type' => 'DreambookPattern', 'id' => 'Веник',
              'attributes' => {
                'summary' => 'Про веник'
              },
              'links' => {
                'self' => api_dreambook_pattern_path(letter: 'В', name: 'Веник')
              }
            },
            {
              'type' => 'DreambookPattern', 'id' => 'Вода',
              'attributes' => {
                'summary' => 'Про воду'
              },
              'links' => {
                'self' => api_dreambook_pattern_path(letter: 'В', name: 'Вода')
              }
            }
          ]
        }

        expect(response.parsed_body).to eq(expected_response)
      end
    end

    context 'when there are no patterns starting with this letter' do
      before do
        # /api/dreambook/Ъ
        get '/api/dreambook/%D0%AA'
      end

      it 'returns empty list' do
        expect(response.parsed_body).to eq({ 'data' => [] })
      end
    end
  end

  describe 'get /api/dreambook/:letter/:pattern' do
    context 'when pattern is found' do
      before do
        # '/api/dreambook/А/Арбуз'
        get '/api/dreambook/%D0%90/%D0%90%D1%80%D0%B1%D1%83%D0%B7'
      end

      it 'returns pattern description' do # rubocop:disable RSpec/ExampleLength
        expected_response = {
          'data' => {
            'id' => 'Арбуз',
            'type' => 'DreamPattern',
            'attributes' => {
              'summary' => 'Про арбуз',
              'description' => 'Подробнее про арбуз'
            }
          }
        }

        expect(response.parsed_body).to eq(expected_response)
      end
    end

    context 'when pattern is not found' do
      before do
        # /api/dreambook/Ъ/Ъыь
        get '/api/dreambook/%D0%AA/%D0%AA%D1%8B%D1%8C'
      end

      it 'responds with Not Found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
