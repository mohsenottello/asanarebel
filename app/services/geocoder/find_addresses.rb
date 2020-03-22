module Geocoder
  class FindAddresses
    Address = Struct.new(:latitude, :longtitude, :display_name, keyword_init: true)

    def initialize(address)
      raise ArgumentError, "String is expected as 'address'" unless address.is_a?(String)

      @address = address
    end

    def procceed
      Rails.cache.fetch(@address, expires_in: (Rails.application.secrets.locationiq[:cache_expiration_period_in_minutes] || 30).minutes) do
        db_locations || api_locations
      end
    end

    private

    def db_locations
      return unless Rails.application.secrets.search_locations[:use_db]

      Location.search_by_keywords(@address.split(' ')).presence
    end

    def api_locations
      addresses = Communicator.procceed(@address)
      save_in_db(addresses)

      addresses.map do |address|
        Address.new(
          latitude: address["lat"],
          longtitude: address["lon"],
          display_name: address["display_name"]
        )
      end
    end

    def save_in_db(addresses)
      return unless Rails.application.secrets.search_locations[:save_db]

      Workers::SaveLocationsWorker.perform_async(addresses)
    end
  end
end
