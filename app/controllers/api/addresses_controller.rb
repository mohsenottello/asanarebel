module Api
  class AddressesController < ApplicationController
    def search
      return render_error(status_code: :unprocessable_entity) if params[:address].blank?

      result = Geocoder::FindAddresses.new(params[:address]).procceed

      render json: result
    rescue RequestManager::ErrorManager => e
      render_error(status_code: e.error_code, message: e.error_message)
    end
  end
end
