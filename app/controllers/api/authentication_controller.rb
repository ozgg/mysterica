# frozen_string_literal: true

module Api
  # Authentication
  class AuthenticationController < ApplicationController
    before_action :require_authentication

    # get /me
    def me
      @user = current_user
    end
  end
end
