# frozen_string_literal: true

module Api
  # Authentication
  class AuthenticationController < ApplicationController
    before_action :require_authentication, except: :login

    # get /me
    def me
      @user = current_user
    end

    # post /login
    def login
      slug = params[:login].to_s
      password = params[:password].to_s

      result = Components::UsersComponent.authenticate(slug, password)

      render_authentication_result(result)
    end

    private

    def render_authentication_result(result)
      if result.respond_to?(:uuid)
        @token = JWT.encode({ user_id: result.uuid }, ENV.fetch('JWT_KEY'))
      else
        unauthorized = {
          errors: [
            { code: 'invalid_credentials', status: 401 }
          ]
        }

        render json: unauthorized, status: :unauthorized
      end
    end
  end
end