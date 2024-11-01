# frozen_string_literal: true

json.data do
  json.type @user.class
  json.id @user.uuid
  json.attributes do
    json.call(@user, :slug, :email, :profile)
  end
end
