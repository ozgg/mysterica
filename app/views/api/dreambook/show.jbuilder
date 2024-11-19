# frozen_string_literal: true

json.data do
  json.id @entity.name
  json.type @entity.class.to_s
  json.attributes do
    json.call(@entity, :summary, :description)
  end
end
