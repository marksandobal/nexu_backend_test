class UpdateModelForm < BaseForm
  validates :average_price, numericality: { greater_than: 100000 }

  def update
    if valid?
      find_brand
      find_model
      update_model
    else
      false
    end
  end

  private

  def update_model
    model.update(average_price: average_price)
  end
end
