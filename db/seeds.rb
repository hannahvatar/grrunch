Product.destroy_all
chocolate_chip_cookies = Product.new(product_name: "The Decadent Chocolate Chunk Cookie", name: "Chocolate chip cookies", brand: "President's Choice", weight: "300g")
chocolate_chip_cookies.save!

all_purpose_white_flour = Product.new(product_name: "White flour", name: "All purpose white flour", brand: "Robin Hood", weight: "1kg")
all_purpose_white_flour.save!
