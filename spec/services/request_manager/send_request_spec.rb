require 'rails_helper'

RSpec.describe RequestManager::SendRequest, type: :feature do
  let(:success_response) { Net::HTTPSuccess.new(nil, '200', 'message') }
  let(:failed_response) { Net::HTTPResponse.new(nil, '400', 'error') }

  describe "check ok response" do
    it "ok response" do
      expect_any_instance_of(Net::HTTP).to receive(:send_request).and_return(success_response)
      expect(success_response).to receive(:body).and_return('test')

      expect(subject.procceed).to eql('test')
    end
  end

  describe "check failed response" do
    it "failed response" do
      expect_any_instance_of(Net::HTTP).to receive(:send_request).exactly(3).times.and_return(failed_response)
      expect(failed_response).to receive(:body).and_return('test').twice

      expect { subject.procceed }.to raise_error(RequestManager::ErrorManager)
    end
  end
end
