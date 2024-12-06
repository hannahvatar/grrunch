Product.destroy_all
chocolate_chip_cookies = Product.new(name: "Chocolate chip cookies", brand: "President's Choice", weight: "300g")
chocolate_chip_cookies.save!

all_purpose_white_flour = Product.new(name: "All purpose white flour", brand: "Robin Hood", weight: "1kg")
all_purpose_white_flour.save!
