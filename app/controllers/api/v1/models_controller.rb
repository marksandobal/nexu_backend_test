module Api
  module V1
    class ModelsController < ApplicationController
      def index
        if params[:brand_id].present?
          brand = set_brand
          render json: { errors: 'Brand not found' },
            status: :not_found and return if brand.blank?

          models = Filter.new(params, Model).apply(brand.models)
        else
          models = Filter.new(params, Model).apply
        end

        render json: models, each_serializer: Api::V1::ModelSerializer, status: :ok
      end

      def create
        form = CreateModelForm.new(model_params.merge(brand_id: params[:brand_id]))
        if form.save
          render json: form.model, serializer: Api::V1::ModelSerializer, status: :created
        else
          render json: form.errors, status: :unprocessable_entity
        end

      rescue ActiveRecord::RecordInvalid, BrandException, ModelException => error
        render json: { errors: error.message }, status: :unprocessable_entity
      end

      def update
        form = UpdateModelForm.new(update_params)
        if form.update
          render json: form.model, serializer: Api::V1::ModelSerializer, status: :ok
        else
          render json: form.errors, status: :unprocessable_entity
        end

      rescue ActiveRecord::RecordInvalid, BrandException, ModelException => error
        render json: { errors: error.message }, status: :unprocessable_entity
      end

      private

      def model_params
        params.require(:model)
          .permit(:name, :average_price)
      end

      def update_params
        model_params.merge(model_id: params[:id])
      end

      def set_brand
        Brand.find_by(id: params[:brand_id])
      end
    end
  end
end
