class Brand < ApplicationRecord
  has_many :models

  # Validation is added to this side, since it could not be included in the formObject
  # include ActiveModel::Validations does not work in the form object
  validates :name, uniqueness: true
end
