module Geocoder
  class FindAddresses
    def initialize(address)
      raise ArgumentError, "String is expected as 'address'" unless address.is_a?(String)

      @address = address
    end

    def procceed
      Rails.cache.fetch(@address, expires_in: (Rails.application.secrets.locationiq[:cache_expiration_period_in_minutes] || 30).minutes) do
        Communicator.procceed(@address).map { |address| address.slice("lat", "lon", "display_name") }
      end
    end
  end
end
