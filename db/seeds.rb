# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ['Action', 'Comedy', 'Drama', 'Horror'].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

models = JSON.parse(File.read(Rails.root.join('lib', 'seeds', 'models.json')))

brands = models.map { |model| model['brand_name'] }.uniq

ActiveRecord::Base.transaction do
  brands.each do |brand|
    Brand.create!(name: brand)
  end
end

grouped_models = models.group_by {|d| d['brand_name']}

grouped_models.each do |brand, models|
  brand = Brand.find_by(name: brand)
  ActiveRecord::Base.transaction do
    models.each do |model|
      attr_model = {
        name: model['name'].upcase,
        brand: brand,
        average_price: model['average_price']
      }
  
      Model.create!(attr_model)
    end
  end
end
