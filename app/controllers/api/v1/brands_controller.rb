module Api
  module V1
    class BrandsController < ApplicationController
      def index
        brands = Brand.all
        render json: brands, each_serializer: Api::V1::BrandSerializer, status: :ok
      end

      def create
        # We apply one of the solid principles: Single Responsibility Principle
        # We will pass the responsibility of validating fields before storing in a form type
        # class and not directly in the model. which allows us to keep our code cleaner and more readable
        form = CreateBrandForm.new(brand_params)
        if form.save
          render json: form.brand, serializer: Api::V1::BrandSerializer, status: :created
        else
          render json: form.errors, status: :unprocessable_entity
        end

      rescue ActiveRecord::RecordInvalid => error
        render json: { errors: error.message }, status: :unprocessable_content
      end

      private

      def brand_params
        params.require(:brand)
          .permit(:name, :average_price)
      end
    end
  end
end
