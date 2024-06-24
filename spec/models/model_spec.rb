require 'rails_helper'

RSpec.describe Model, type: :model do
  let!(:name) { 'Model' }

  describe 'validations' do
    it { should belong_to(:brand) }
  end

  context '#exist?' do
    let!(:model) { create(:model, name: 'MAZDA 3') }

    it 'return true if model exist' do
      expect(described_class.exist?(model.name)).to be_truthy
    end

    it 'return false if model not exist' do
      expect(described_class.exist?('MAZDA 2')).to be_falsey
    end
  end
end
