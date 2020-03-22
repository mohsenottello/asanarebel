require 'rails_helper'

RSpec.describe Geocoder::FindAddresses, type: :feature do
  before { Rails.cache.clear }

  let(:subject) { described_class.new('test2') }
  let(:api_response) { [{ "lat" => "51.1576661", "lon" => "-1.4458572", "display_name" => "Test, Test Valley, Hampshire" }] }
  let!(:location) { create(:location, display_name: 'test3') }

  let(:response) do
    Geocoder::FindAddresses::Address.new(
      latitude: "51.1576661",
      longtitude: "-1.4458572",
      display_name: "Test, Test Valley, Hampshire"
    )
  end

  describe '.new' do
    it { expect { described_class.new(1) }.to raise_exception(ArgumentError, "String is expected as 'address'") }
  end

  describe "check ok response without cache with db" do
    it "ok response" do
      expect(described_class.new('test3').procceed.ids).to eql([location.id])
    end
  end

  describe "check ok response without cache with 3rd party" do
    it "ok response" do
      expect(Geocoder::Communicator).to receive(:procceed).and_return(api_response)
      expect(Geocoder::Workers::SaveLocationsWorker).to receive(:perform_async)

      expect(subject.procceed).to eql([response])
    end
  end

  describe "check ok response with cache" do
    it "ok response" do
      Rails.cache.fetch('test2') { [response] }

      expect(subject.procceed).to eql([response])
    end
  end
end
