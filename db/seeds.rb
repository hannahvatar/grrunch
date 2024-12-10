# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

# User.destroy_all
Store.destroy_all
Product.destroy_all
ProductStore.destroy_all
ProductPrice.destroy_all
# List.destroy_all

file_path_cookies = Rails.root.join('db', 'data', 'Chocolate_chips_cookies.json')
file_path_beef = Rails.root.join('db', 'data', "Ground_Beef.json")
file_path_strawberries = Rails.root.join('db', 'data', "Strawberries.json")
file_path_wine = Rails.root.join('db', 'data', "Wine.json")
file_path_yogurt = Rails.root.join('db', 'data', "Yogurts.json")
file_path_water = Rails.root.join('db', 'data', "Water.json")

file_content_cookies = File.read(file_path_cookies)
file_content_beef = File.read(file_path_beef)
file_content_strawberries = File.read(file_path_strawberries)
file_content_wine = File.read(file_path_wine)
file_content_yogurt = File.read(file_path_yogurt)
file_content_water = File.read(file_path_water)

products = JSON.parse(file_content_cookies)
data1 = products["ChocolateChipsCookies"]
products = JSON.parse(file_content_beef)
data2 = products["GroundBeef"]
products = JSON.parse(file_content_strawberries)
data3 = products["Strawberries"]
products = JSON.parse(file_content_wine)
data4 = products["Wine"]
products = JSON.parse(file_content_yogurt)
data5 = products["yogurts"]
products = JSON.parse(file_content_water)
data6 = products["Water"]
data_list = [data1, data2, data3, data4, data5, data6]

# puts "Creating user..."
# user1 = User.create!(email: "test@email.com", password: "123456")
# puts "User created!"

# puts "Creating list..."
# list1 = List.create!(user: user1)
# puts "List created!"

puts "Creating store..."
store =Store.create!(name: "Provigo")
puts "Store created."

puts "Creating products..."
data_list.each do |data|
  data.each do |product|
    data_product = Product.create!(name: product["product_name"], brand: product["brand"], weight: product["weight"])
    ProductPrice.create!(price: product["price"], product: data_product)
    ProductStore.create!(product: data_product, store: store)
  end
end
# data1.each do |product|
#   Product.create!(name: product["product_name"], brand: product["brand"], weight: 300.50, list: list1)
# end
# data2.each do |product|
#   Product.create!(name: product["product_name"], brand: product["brand"], weight: 300.50, list: list1)
# end
# data3.each do |product|
#   Product.create!(name: product["product_name"], brand: product["brand"], weight: 300.50, list: list1)
# end
# data4.each do |product|
#   Product.create!(name: product["product_name"], brand: product["brand"], weight: 300.50, list: list1)
# end
# data5.each do |product|
#   Product.create!(name: product["product_name"], brand: product["brand"], weight: 300.50, list: list1)
# end
puts "Created products!"
