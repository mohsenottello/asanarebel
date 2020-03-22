# frozen_string_literal: true

module Geocoder
  module Workers
    # Geocoder::Workers::SaveLocationsWorker
    class SaveLocationsWorker
      include Sidekiq::Worker

      def perform(addresses_attributes)
        addresses_attributes.map do |address|
          Location.create(
            latitude: address["lat"],
            longtitude: address["lon"],
            display_name: address["display_name"],
            data: address
          )
        end
      end
    end
  end
end
