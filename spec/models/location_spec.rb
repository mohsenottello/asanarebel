require 'rails_helper'

RSpec.describe Location, type: :model do
  let!(:location) { create(:location, display_name: 'test') }
  let(:subject) { described_class.new }
  context 'validations' do
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longtitude) }
    it { is_expected.to validate_presence_of(:display_name) }
    it { is_expected.to allow_value(-89.99).for(:latitude) }
    it { is_expected.to allow_value(179.99).for(:longtitude) }
    it { is_expected.to validate_uniqueness_of(:display_name) }
  end

  context 'scopes' do
    it 'find_by_keywords' do
      expect(described_class.search_by_keywords([:test]).count).to eql(1)
    end
  end
end
