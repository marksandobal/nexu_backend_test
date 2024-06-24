class CreateBrandForm < BaseForm
  validates :name, presence: true

  def save
    if valid?
      create_brand
    else
      false
    end
  end

  private

  def create_brand
    @brand = ::Brand.new(name: name, average_price: average_price)
    @brand.save!
  end
end
