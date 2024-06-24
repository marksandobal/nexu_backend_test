module Api
  module V1
    class ModelSerializer < ActiveModel::Serializer
      attributes :id, :name, :average_price

      def average_price
        object.average_price.to_f
      end
    end
  end
end
