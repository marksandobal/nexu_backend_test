class CreateModelForm < BaseForm
  validates :name, presence: true
  validates :brand_id, presence: true
  validates :average_price, numericality: { greater_than: 100000 }, if: -> { average_price.present? }

  def save
    if valid?
      find_brand
      find_or_create_model
    else
      false
    end
  end

  private

  def find_or_create_model
    raise ModelException.new('This model already exists', 10) if brand.models.exist?(name)

    create_model
  end

  def create_model
    @model = ::Model.new(name: name.upcase, brand: brand, average_price: average_price)
    @model.save!
  end
end
