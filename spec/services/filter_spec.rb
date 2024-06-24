require "rails_helper"

RSpec.describe Filter do
  let(:name) { 'Filters' }
  
  context 'When filter with model' do
    let!(:model) { create(:model, average_price: 101_000) }

    it 'return models' do
      records = Filter.new({ greater: 100_000 }, Model).apply(model.brand.models)

      expect(records.count).to eq(1)
      expect(records.first.id).to eq(model.id)
    end
  end

  context 'When not pass records in apply method' do
    let!(:model) { create(:model, average_price: 101_000) }

    it 'return all records' do
      records = Filter.new({ greater: 100_000 }, Model).apply

      expect(records.count).to eq(1)
      expect(records.first.id).to eq(model.id)
    end
  end

  context 'When filter with brand' do
    let!(:brand) { create(:brand, name: 'Mazda',  average_price: 101_000) }

    it 'return models' do
      records = Filter.new({ name: 'Mazda' }, Brand).apply(Brand.all)

      expect(records.count).to eq(1)
      expect(records.first.id).to eq(brand.id)
    end
  end
end
