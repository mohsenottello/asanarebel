module Geocoder
  class FindAddresses
    def initialize(address)
      raise ArgumentError, "String is expected as 'address'" unless address.is_a?(String)

      @address = address
    end

    def procceed
      Communicator.procceed(@address).map { |address| address.slice("lat", "lon", "display_name") }
    end
  end
end
