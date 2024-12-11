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
##### UNCOMMENT THESE 4 LINES THE FIRST TIME
#  ProductPrice.destroy_all
#  Store.destroy_all
#  Product.destroy_all
##### COMMENT THEM AGAIN AFTER YOU RUN RAILS DB SEED

# List.destroy_all

file_path_provigo = Rails.root.join('db', 'data', "provigo_products.json")
file_path_maxi = Rails.root.join('db', 'data', "maxi_products.json")
file_path_loblaws = Rails.root.join('db', 'data', "loblaws_products.json")

file_content_provigo = File.read(file_path_provigo)
file_content_maxi = File.read(file_path_maxi)
file_content_loblaws = File.read(file_path_loblaws)

products = JSON.parse(file_content_provigo)
data1 = products
products = JSON.parse(file_content_maxi)
data2 = products
products = JSON.parse(file_content_loblaws)
data3 = products
data_list = [data1, data2, data3]

# puts "Creating user..."
# user1 = User.create!(email: "test@email.com", password: "123456")
# puts "User created!"

# puts "Creating list..."
# list1 = List.create!(user: user1)
# puts "List created!"

puts "Creating stores..."

# UNCOMMENT THESE 3 LINES THE FIRST TIME
# provigo = Store.create!(name: "Provigo")
# maxi = Store.create!(name: "Maxi")
# loblaws = Store.create!(name: "Loblaws")
# COMMENT THEM AFTER YOU RUN RAILS DB SEED

# COMMENT THESE 3 LINES THE FIRST TIME
provigo = Store.find_by(name: "Provigo")
maxi = Store.find_by(name: "Maxi")
loblaws = Store.find_by(name: "Loblaws")
# UNCOMMENT THEM AFTER YOU RUN RAILS DB SEED
stores = [provigo, maxi, loblaws]
puts "Stores created."

puts "Creating products..."
data_list.each_with_index do |data, index|
  data.each do |category, items|
    puts "Category: #{category}"
    items.each do |product|
      data_product = Product.create!(
          name: product["product_name"],
          brand: product["brand"],
          weight: product["weight"],
          img_url: product["img_url"],
          price_per_100_unit: product["price_per_100_unit"]
        )
      puts "Creating product_price..."
      ProductPrice.create!(price: product["price"], product: data_product, scraping_date: Time.now, store: stores[index])
      puts "Product price created!"
    end
  end
end
puts "Products created!"
