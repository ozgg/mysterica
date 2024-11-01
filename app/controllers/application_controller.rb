# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, jwt_key)
  end

  def jwt_token
    @jwt_token ||= decoded_token
  end

  def current_user
    @current_user ||= user_from_token
  end

  def require_authentication
    return unless current_user.nil?

    render json: { errors: { token: 'invalid' } }, status: :unauthorized
  end

  private

  def jwt_key
    @jwt_key ||= ENV.fetch('JWT_KEY')
  end

  def decoded_token
    header = request.headers['Authorization']
    return unless header

    token = header.split[1]
    begin
      JWT.decode(token, jwt_key)
    rescue JWT::DecodeError
      nil
    end
  end

  def user_from_token
    return unless jwt_token

    user_id = decoded_token[0]['user_id']
    User.find_by(uuid: user_id)
  end
end
