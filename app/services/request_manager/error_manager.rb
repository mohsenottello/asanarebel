# frozen_string_literal: true

module RequestManager
  class ErrorManager < StandardError
    attr_reader :error_code, :error_message
    def self.procceed(response)
      self.new(response).procceed
    end

    def initialize(response)
      @response = response

      super(@response.body)
    end

    def procceed
      @error_code = @response.code
      @error_message = @response.body

      self
    end
  end
end
