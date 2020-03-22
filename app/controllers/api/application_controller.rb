module Api
  class ApplicationController < ActionController::API
    before_action :authenticate!
    before_action :set_format

    def authenticate!
      render_error(status_code: :unauthorized, message: 'invalid token') if Rails.application.secrets.search_locations[:token] != request.headers['AuthenticationToken']
    end

    def set_format
      request.format = :json
    end

    def render_error(status_code:, message: nil)
      render json: { errors: 'Can not proceed!', message: message }, status: status_code
    end
  end
end
