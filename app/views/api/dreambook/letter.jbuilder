# frozen_string_literal: true

json.data @collection do |entity|
  json.id entity.name
  json.type 'DreambookPattern'
  json.attributes do
    json.call(entity, :summary)
  end
  json.links do
    json.self api_dreambook_pattern_path(letter: entity.name[0], name: entity.name)
  end
end
