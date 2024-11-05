# frozen_string_literal: true

module Api
  # Users controller
  class UsersController < ApplicationController
    # post /api/join
    def create
      handler = Components::Users::ProfileHandler.new(site: current_site)
      permitted = handler.class.permitted_parameters
      user = handler.register(params.require(:user).permit(permitted))
      if user.id.present?
        @token = encode_token(user_id: user.uuid)
        render 'api/shared/token', status: :created
      else
        @errors = handler.errors
        render 'api/shared/errors', status: :bad_request
      end
    end
  end
end
