require 'rails_helper'

RSpec.describe Api::AddressesController, type: :request do
  let(:json_body) { "[{\"lat\":\"51.1576661\",\"lon\":\"-1.4458572\",\"display_name\":\"Test, Test Valley, Hampshire\"}]" }
  let(:success_response) { Net::HTTPSuccess.new(nil, '200', 'message') }
  let(:failed_response) { Net::HTTPResponse.new(nil, '400', 'error') }
  let!(:token) { create(:token, token_hash: 'test') }

  describe "get search_address" do
    before { get "/api/search_address" }

    it "unauthorized response" do
      expect(response).to have_http_status(401)
    end
  end

  describe "get search_address" do
    before { get "/api/search_address", headers: { AuthenticationToken: "test" } }

    it "unprocessable_entity response" do
      expect(response).to have_http_status(422)
    end
  end

  describe "get search_address" do
    before do
      expect_any_instance_of(Net::HTTP).to receive(:send_request).and_return(success_response)
      expect(success_response).to receive(:body).and_return(json_body)

      get "/api/search_address", headers: { AuthenticationToken: "test" }, params: { address: "test" }
    end

    it "ok response" do
      expect(response).to have_http_status(200)
      hash_body = JSON.parse(response.body)
      expect(hash_body.first.keys).to match_array(["longtitude", "latitude", "display_name"])
    end
  end

  describe "get search_address" do
    before do
      expect_any_instance_of(Net::HTTP).to receive(:send_request).twice.and_return(failed_response)
      expect(failed_response).to receive(:body).and_return('test').twice
      get "/api/search_address", headers: { AuthenticationToken: "test" }, params: { address: "test" }
    end

    it "time out integration response" do
      expect(response).to have_http_status(400)
    end
  end
end
