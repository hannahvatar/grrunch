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
ProductStore.destroy_all
ProductPrice.destroy_all
Store.destroy_all
Product.destroy_all
# List.destroy_all

file_path_cookies = Rails.root.join('db', 'data', 'chocolate_chips_cookies.json')
file_path_beef = Rails.root.join('db', 'data', "ground_beef.json")
file_path_strawberries = Rails.root.join('db', 'data', "strawberries.json")
file_path_wine = Rails.root.join('db', 'data', "wine.json")
file_path_yogurt = Rails.root.join('db', 'data', "yogurt.json")
file_path_water = Rails.root.join('db', 'data', "water.json")
file_path_orange = Rails.root.join('db', 'data', "orange_juice.json")

file_content_cookies = File.read(file_path_cookies)
file_content_beef = File.read(file_path_beef)
file_content_strawberries = File.read(file_path_strawberries)
file_content_wine = File.read(file_path_wine)
file_content_yogurt = File.read(file_path_yogurt)
file_content_water = File.read(file_path_water)
file_content_orange = File.read(file_path_orange)

products = JSON.parse(file_content_cookies)
data1 = products["ChocolateChipsCookies"]
products = JSON.parse(file_content_beef)
data2 = products["GroundBeef"]
products = JSON.parse(file_content_strawberries)
data3 = products["Strawberries"]
products = JSON.parse(file_content_wine)
data4 = products["Wine"]
products = JSON.parse(file_content_yogurt)
data5 = products["Yogurt"]
products = JSON.parse(file_content_water)
data6 = products["Water"]
products = JSON.parse(file_content_orange)
data7 = products["OrangeJuice"]
data_list = [data1, data2, data3, data4, data5, data6, data7]

# puts "Creating user..."
# user1 = User.create!(email: "test@email.com", password: "123456")
# puts "User created!"

# puts "Creating list..."
# list1 = List.create!(user: user1)
# puts "List created!"

puts "Creating store..."
provigo = Store.create!(name: "Provigo")
puts "Store created."

puts "Creating products..."
data_list.each do |data|
  data.each do |product|
    data_product = Product.create!(name: product["product_name"],
      brand: product["brand"],
      weight: product["weight"],
      img_url: product["img_url"],
      price_per_100_unit: product["price_per_100_unit"]
    )
    puts "Creating product_store..."
    ProductStore.create!(product: data_product, store: provigo)
    puts "Product store created!"
    puts "Creating product_price..."
    ProductPrice.create!(price: product["price"], product: data_product)
    puts "Product price created!"
  end
end
puts "Products created!"
