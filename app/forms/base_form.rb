class BaseForm
  include ActiveModel::Model

  attr_accessor :name, :average_price, :brand_id, :model_id, :brand, :model

  def find_brand
    @brand = ::Brand.find(brand_id)

  rescue ActiveRecord::RecordNotFound => error
    raise BrandException.new(error.message, 404)
  end

  def find_model
    @model = Model.find(model_id)

  rescue ActiveRecord::RecordNotFound => error
    raise ModelException.new("Couldn't find Model with 'id'=#{model_id}", 404)
  end
end
