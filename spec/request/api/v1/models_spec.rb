require 'rails_helper'

RSpec.describe Api::V1::ModelsController, type: :request do
  let(:name) { "Models" }
  let(:valid_headers) { { 'Accept' => 'application/vnd.nexu-backend-api.v1+json' } }

  describe 'GET #index' do
    context 'When there are models' do
      let!(:model) { create(:model) }

      it 'return models' do
        get "/api/brands/#{model.brand_id}/models", headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json_body['models'].count).to eq(1)
        expect(json_body['models'][0]['name']).to eq(model.name)
        expect(json_body['models'][0]['average_price']).to eq(model.average_price)
      end
    end

    context "when brand not exist" do
      it 'return error' do
        get "/api/brands/82828282/models", headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:not_found)
        expect(json_body['errors']).to eq("Couldn't find Brand with 'id'=82828282")
      end
    end
  end

  describe 'POST #create' do
    context 'When create model' do
      let!(:brand) { create(:brand, name: 'Mazda') }

      it 'return model created' do
        post "/api/brands/#{brand.id}/models", params: { model: { name: 'Mazda 2', average_price: 150_000 } },
          headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(json_body['model']['name']).to eq('Mazda 2'.upcase)
        expect(json_body['model']['average_price']).to eq(150_000)
      end
    end

    context 'When brand not exist' do
      it 'return error' do
        post "/api/brands/82828282/models", params: { model: { name: 'Mazda 2', average_price: 150_000 } },
          headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_body['errors']['code']).to eq(404)
        expect(json_body['errors']['message']).to eq("Couldn't find Brand with 'id'=82828282")
      end
    end

    context 'When model exist' do
      let!(:brand) { create(:brand, name: 'Mazda') }
      let!(:model) { create(:model, name: 'MAZDA 2', brand: brand) }

      it 'return error' do
        post "/api/brands/#{brand.id}/models", params: { model: { name: 'Mazda 2', average_price: 150_000 } },
          headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_body['errors']['code']).to eq(10)
        expect(json_body['errors']['message']).to eq("This model already exists")
      end
    end
  end

  describe 'PUT #update' do
    context 'When update model' do
      let!(:model) { create(:model, name: 'MAZDA 2', average_price: 100_000) }

      it 'return model updated' do
        put "/api/brands/#{model.brand_id}/models/#{model.id}", params: { model: { average_price: 150_000 } },
          headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json_body['model']['average_price']).to eq(150_000)
      end
    end

    context 'When brand not exist' do
      let!(:model) { create(:model, name: 'MAZDA 2', average_price: 100_000) }

      it 'return error' do
        put "/api/brands/82828282/models/#{model.id}", params: { model: { average_price: 150_000 } },
          headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_body['errors']['code']).to eq(404)
        expect(json_body['errors']['message']).to eq("Couldn't find Brand with 'id'=82828282")
      end
    end

    context 'When model not exist' do
      let!(:brand) { create(:brand) }

      it 'return error' do
        put "/api/brands/#{brand.id}/models/82828282", params: { model: { average_price: 150_000 } },
          headers: valid_headers

        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_body['errors']['code']).to eq(404)
        expect(json_body['errors']['message']).to eq("Couldn't find Model with 'id'=82828282")
      end
    end
  end
end
