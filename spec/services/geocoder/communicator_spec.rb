require 'rails_helper'

RSpec.describe Geocoder::Communicator, type: :feature do
  let(:subject) { described_class.new('test') }
  let(:json_body) { "[{\"lat\":\"51.1576661\",\"lon\":\"-1.4458572\",\"display_name\":\"Test, Test Valley, Hampshire\"}]" }
  let(:success_response) { Net::HTTPSuccess.new(nil, '200', 'message') }
  let(:failed_response) { Net::HTTPResponse.new(nil, '400', 'error') }

  describe "check ok response" do
    it "ok response" do
      expect_any_instance_of(Net::HTTP).to receive(:send_request).and_return(success_response)
      expect(success_response).to receive(:body).and_return(json_body)

      expect(subject.procceed).to eql(JSON.parse(json_body))
    end
  end

  describe "check failed response" do
    it "failed response" do
      expect_any_instance_of(Net::HTTP).to receive(:send_request).twice.and_return(failed_response)
      expect(failed_response).to receive(:body).and_return('test').twice

      expect { subject.procceed }.to raise_error(RequestManager::ErrorManager)
    end
  end
end
