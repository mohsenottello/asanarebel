require 'rails_helper'

RSpec.describe Geocoder::FindAddresses, type: :feature do
  before { Rails.cache.clear }

  let(:subject) { described_class.new('test') }
  let(:response) { [{ "lat" => "51.1576661", "lon" => "-1.4458572", "display_name" => "Test, Test Valley, Hampshire" }] }

  describe '.new' do
    it { expect { described_class.new(1) }.to raise_exception(ArgumentError, "String is expected as 'address'") }
  end

  describe "check ok response without cache" do
    it "ok response" do
      expect(Geocoder::Communicator).to receive(:procceed).and_return(response)

      expect(subject.procceed).to eql(response)
    end
  end

  describe "check ok response with cache" do
    it "ok response" do
      Rails.cache.fetch('test') { response }

      expect(subject.procceed).to eql(response)
    end
  end
end
