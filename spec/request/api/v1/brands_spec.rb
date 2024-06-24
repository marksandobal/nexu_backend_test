require 'rails_helper'

RSpec.describe Api::V1::BrandsController, type: :request do
  # Rspec in Rails 7 have problem for run test without let(:name)
  let(:name) { "Brands" }
  let(:valid_headers) do
    { 'Accept' => 'application/vnd.nexu-backend-api.v1+json' }
  end

  describe 'GET #index' do
    context 'When there are brands' do
      let!(:brand) { create(:brand) }

      it 'return countries list' do
        get "/api/brands", headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json_body['brands'].count).to eq(1)
        expect(json_body['brands'][0]['name']).to eq(brand.name)
        expect(json_body['brands'][0]['average_price']).to eq(brand.average_price)
      end
    end

    context 'When there are no brands' do
      it 'return error if brand not exist' do
        get '/api/brands', headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json_body['brands'].count).to eq(0)
      end
    end
  end

  describe 'POST #create' do
    context 'When create brand' do
      it 'return brand created' do
        post '/api/brands', params: { brand: { name: 'Audi' } }, headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(json_body['brand']['name']).to eq('Audi')
      end
    end

    context 'When brand exist' do
      let!(:brand) { create(:brand, name: 'Audi') }

      it 'return error' do
        post '/api/brands', params: { brand: { name: brand.name } }, headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_body['errors']).to eq('Validation failed: Name has already been taken')
      end
    end
  end
end
