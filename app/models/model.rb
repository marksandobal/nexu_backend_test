class Model < ApplicationRecord
  belongs_to :brand

  def self.exist?(name)
    # assuming that the standard is to write the model name in capital letters
    where(name: name.upcase).count > 0
  end
end
