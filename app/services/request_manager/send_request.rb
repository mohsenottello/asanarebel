# frozen_string_literal: true

module RequestManager
  # reuqest manager
  class SendRequest
    def initialize
    end

    def procceed
      uri = URI.parse(link)
      uri.query = URI.encode_www_form(query)
      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = use_ssl
      response = nil

      numbser_of_requests.times do
        response = http.send_request(request_type, uri.request_uri, body.to_json, header)
        next unless response.is_a?(Net::HTTPSuccess)

        return parse_response(response)
      end

      raise ErrorManager.procceed(response)
    end

    private

    def link
      'https://www.google.com'
    end

    def query
      {}
    end

    def use_ssl
      true
    end

    def request_type
      'GET'
    end

    def numbser_of_requests
      3
    end

    def body
      {}
    end

    def header
      {}
    end

    def parse_response(response)
      response.body
    end
  end
end
