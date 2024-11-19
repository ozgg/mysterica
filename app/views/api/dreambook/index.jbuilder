# frozen_string_literal: true

json.data @letters do |letter|
  json.type 'DreambookLetter'
  json.id letter
  json.links do
    json.self api_dreambook_letter_path(letter:)
  end
end
