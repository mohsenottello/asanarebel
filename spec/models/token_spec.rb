require 'rails_helper'

RSpec.describe Token, type: :model do
  let(:subject) { described_class.new }

  context 'validations' do
    it { is_expected.to validate_presence_of(:token_hash) }
    it { is_expected.to validate_presence_of(:customer_name) }
    it { is_expected.to validate_uniqueness_of(:token_hash) }
  end
end
