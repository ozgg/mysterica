# frozen_string_literal: true

module Api
  # Users controller
  class UsersController < ApplicationController
    before_action :require_authentication, except: :create

    # post /api/join
    def create
      handler = Components::Users::ProfileHandler.new(site: current_site)
      permitted = handler.class.permitted_parameters
      user = handler.register(params.expect(user: [permitted]))
      if user.id.present?
        @token = encode_token(user_id: user.uuid)
        render 'api/shared/token', status: :created
      else
        @errors = handler.errors
        render 'api/shared/errors', status: :bad_request
      end
    end

    # patch /api/me
    def update
      handler = Components::Users::ProfileHandler.new(site: current_site, user: current_user)
      permitted = handler.class.permitted_parameters
      user = handler.update(params.expect(user: [permitted]))
      # byebug
      if handler.errors.blank?
        @user = user
        render 'api/authentication/me'
      else
        @errors = handler.errors
        render 'api/shared/errors', status: :unprocessable_entity
      end
    end
  end
end
