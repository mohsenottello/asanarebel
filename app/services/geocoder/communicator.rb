module Geocoder
  class Communicator < ::RequestManager::SendRequest
    def self.procceed(address)
      self.new(address).procceed
    end

    def initialize(address)
      raise ArgumentError, "String is expected as 'address'" unless address.is_a?(String)

      @address = address
    end

    private

    def link
      Rails.application.secrets.locationiq[:link]
    end

    def numbser_of_requests
      Rails.application.secrets.locationiq[:timeout_request_num]
    end

    def parse_response(response)
      JSON.parse response.body
    end

    def query
      {
        key: Rails.application.secrets.locationiq[:api_key],
        q: @address,
        format: 'json'
      }
    end
  end
end
