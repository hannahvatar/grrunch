require 'selenium-webdriver'
require 'nokogiri'
require "json"

# VARIABLES
@counter = 0
@products = []

# PROVIGO
# provigo_diet_coke = "https://www.provigo.ca/en/search?search-bar=Diet%20coke"
# provigo_orange_juice = "https://www.provigo.ca/en/search?search-bar=orange%20juice"
# provigo_strawberries = "https://www.provigo.ca/en/search?search-bar=strawberries"
# provigo_yogurt = "https://www.provigo.ca/en/search?search-bar=yogurt"
# provigo_vanilla_ice_cream = "https://www.provigo.ca/en/search?search-bar=vanilla%20ice%20cream"
# provigo_ground_beef = "https://www.provigo.ca/en/search?search-bar=ground%20beef"
# provigo_chicken = "https://www.provigo.ca/en/search?search-bar=chicken"
# provigo_eggs = "https://www.provigo.ca/en/search?search-bar=eggs"
# provigo_toilet_paper = "https://www.provigo.ca/en/search?search-bar=toilet%20paper"
# provigo_corn_flakes = "https://www.provigo.ca/en/search?search-bar=corn%20flakes"
# provigo_doritos = "https://www.provigo.ca/en/search?search-bar=doritos"
# provigo_bolognese_sauce = "https://www.provigo.ca/en/search?search-bar=bolognese%20sauce"
# provigo_butter = "https://www.provigo.ca/en/search?search-bar=butter"
# provigo_frozen_pizza = "https://www.provigo.ca/en/search?search-bar=frozen%20pizza"
# provigo_urls = [provigo_diet_coke, provigo_orange_juice, provigo_strawberries,
#                 provigo_yogurt, provigo_vanilla_ice_cream, provigo_ground_beef,
#                 provigo_chicken, provigo_eggs, provigo_toilet_paper,
#                 provigo_corn_flakes, provigo_doritos, provigo_bolognese_sauce,
#                 provigo_butter, provigo_frozen_pizza]

# # MAXI
# maxi_diet_coke = "https://www.maxi.ca/en/search?search-bar=Diet+coke"
# maxi_orange_juice = "https://www.maxi.ca/en/search?search-bar=orange%20juice"
# maxi_strawberries = "https://www.maxi.ca/en/search?search-bar=strawberries"
# maxi_yogurt = "https://www.maxi.ca/en/search?search-bar=yogurt"
# maxi_vanilla_ice_cream = "https://www.maxi.ca/en/search?search-bar=vanilla%20ice%20cream"
# maxi_ground_beef = "https://www.maxi.ca/en/search?search-bar=ground%20beef"
# maxi_chicken = "https://www.maxi.ca/en/search?search-bar=chicken"
# maxi_eggs = "https://www.maxi.ca/en/search?search-bar=eggs"
# maxi_toilet_paper = "https://www.maxi.ca/en/search?search-bar=toilet%20paper"
# maxi_corn_flakes = "https://www.maxi.ca/en/search?search-bar=corn%20flakes"
# maxi_doritos = "https://www.maxi.ca/en/search?search-bar=doritos"
# maxi_bolognese_sauce = "https://www.maxi.ca/en/search?search-bar=bolognese%20sauce"
# maxi_butter = "https://www.maxi.ca/en/search?search-bar=butter"
# maxi_frozen_pizza = "https://www.maxi.ca/en/search?search-bar=frozen%20pizza"
# maxi_urls = [maxi_diet_coke, maxi_orange_juice, maxi_strawberries,
#              maxi_yogurt, maxi_vanilla_ice_cream, maxi_ground_beef,
#              maxi_chicken, maxi_eggs, maxi_toilet_paper,
#              maxi_corn_flakes, maxi_doritos, maxi_bolognese_sauce,
#              maxi_butter, maxi_frozen_pizza]

# LOBLAWS
loblaws_diet_coke = "https://www.loblaws.ca/search?search-bar=Diet%20coke"
loblaws_orange_juice = "https://www.loblaws.ca/search?search-bar=orange%20juice"
loblaws_strawberries = "https://www.loblaws.ca/search?search-bar=strawberries"
loblaws_yogurt = "https://www.loblaws.ca/search?search-bar=yogurt"
loblaws_vanilla_ice_cream = "https://www.loblaws.ca/search?search-bar=vanilla%20ice%20cream"
loblaws_ground_beef = "https://www.loblaws.ca/search?search-bar=ground%20beef"
loblaws_chicken = "https://www.loblaws.ca/search?search-bar=chicken"
loblaws_eggs = "https://www.loblaws.ca/search?search-bar=eggs"
loblaws_toilet_paper = "https://www.loblaws.ca/search?search-bar=toilet%20paper"
loblaws_corn_flakes = "https://www.loblaws.ca/search?search-bar=corn%20flakes"
loblaws_doritos = "https://www.loblaws.ca/search?search-bar=doritos"
loblaws_bolognese_sauce = "https://www.loblaws.ca/search?search-bar=bolognese%20sauce"
loblaws_butter = "https://www.loblaws.ca/search?search-bar=butter"
loblaws_frozen_pizza = "https://www.loblaws.ca/search?search-bar=frozen%20pizza"
loblaws_urls = [loblaws_diet_coke, loblaws_orange_juice, loblaws_strawberries,
                loblaws_yogurt, loblaws_vanilla_ice_cream, loblaws_ground_beef,
                loblaws_chicken, loblaws_eggs, loblaws_toilet_paper,
                loblaws_corn_flakes, loblaws_doritos, loblaws_bolognese_sauce,
                loblaws_butter, loblaws_frozen_pizza]

keyvalues = ["DietCoke", "OrangeJuice", "Strawberries",
             "Yogurt", "VanillaIceCream", "GroundBeef",
             "Chicken", "Eggs", "ToiletPaper",
             "CornFlakes", "Doritos", "BologneseSauce",
             "Butter", "FrozenPizza"]
# ----------------------------------------------

# METHODS
def return_html_page_source(url)
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  # Initialize the WebDriver for Chrome with the specified options
  driver = Selenium::WebDriver.for :chrome, options: options
  begin
    driver.get(url)
    sleep 10
    html = driver.page_source
    return html
  ensure
    driver.quit
  end
end

def save_dom_to_local(html, file_path)
  doc = Nokogiri::HTML(html)

  File.open(file_path, 'w') do |file|
    file.write(doc)
  end
end

def display_on_console(data)
  puts "Product name: #{data[:product_name]}"
  puts "Brand: #{data[:brand]}"
  puts "Price: #{data[:price]}"
  puts "Weight: #{data[:weight]}"
  puts "Price per 100unit: #{data[:price_per_100_unit]}"
  puts "image_URL: #{data[:img_url]}"
  puts "------------------"
end

def sponsored?(item)
  sponsored = item.at_css("[data-testid='product-badge']")&.text&.strip
  return sponsored == "Sponsored"
end

def get_prices(item)
  rp = item.at_css("[data-testid='regular-price']")&.text&.strip
  nmp = item.at_css("[data-testid='non-members-price']")&.text&.strip
  wp = item.at_css("[data-testid='was-price']")&.text&.strip
  sp = item.at_css("[data-testid='sale-price']")&.text&.strip
  # Extract only the price portion, ignoring "sale" or "about"
  if sp
    price_match = sp.match(/\$[\d.,]+/)
    sp = price_match[0] if price_match
  end
  assign_price({ regular_price: rp, non_members_price: nmp, was_price: wp, sale_price: sp })
end

def assign_price(prices)
  if !prices[:regular_price].nil?
    price = prices[:regular_price]
  elsif !prices[:non_members_price].nil? && !prices[:sale_price].nil?
    price = prices[:non_members_price]
  elsif !prices[:sale_price].nil? && !prices[:was_price].nil?
    price = prices[:sale_price]
  end
  return price
end

def get_weight_and_price_per_unit(item)
  weight_info = item.at_css("[data-testid='product-package-size']")&.text&.strip
  weight = nil
  price_per_100_unit = nil

  if weight_info
    weight_match = weight_info.match(/^([\d.x]+(?:\s?[a-zA-Z]+)?)\b/)
    price_match = weight_info.match(/\$[\d.]+\/\d+[a-zA-Z]+$/)

    weight = weight_match[1] if weight_match
    price_per_100_unit = price_match[0] if price_match
  end
  return { weight: weight, price_per_100_unit: price_per_100_unit }
end

def product_hash(item)
  product_name = item.at_css("[data-testid='product-title']")&.text&.strip
  img_url = item.at_css('div[data-testid="product-image"] img')&.[]('src')
  brand = item.at_css("[data-testid='product-brand']")&.text&.strip
  price = get_prices(item)
  data_weight = get_weight_and_price_per_unit(item)
  weight = data_weight[:weight]
  price_per_100_unit = data_weight[:price_per_100_unit]
  return { product_name:, brand:, price:, weight:, price_per_100_unit:, img_url: }
end

def scrape_product_details(html)
  doc = Nokogiri::HTML(html)
  products = doc.css(".css-1tjthuk")
  products.each do |product|
    items = product.css('.css-0')
    items.each do |item|
      next if sponsored?(item)

      hash = product_hash(item)
      next if %i[product_name brand price weight img_url price_per_100_unit].any? { |key| hash[key].nil? }

      @products << hash
      @counter += 1
      display_on_console(hash)
    end
  end
end

def scrape_from_saved_html_file(url)
  html_content = File.read(url)
  scrape_product_details(html_content)
end

def save_scraped_data_to_json(key_value, file_path)
  # json_output = { key_value => @products }
  if File.exist?(file_path)
    data = JSON.parse(File.read(file_path))
  else
    data = {}
  end

  data[key_value] = @products

  File.open(file_path, "wb") do |file|
    file.write(JSON.generate(data))
  end
end

# EXAMPLES OF HOW TO USE METHODS
# ------------------------TO SAVE DOM LOCALLY--------------------------------
# html = return_html_page_source(provigo_orange_juice)
# save_dom_to_local(html, "orange_juice.html")

# -------------------TO SCRAPE FROM SAVED HTML---------------------------
# scrape_from_saved_html_file("orange_juice.html")

# -------------------TO SCRAPE AND SAVE TO JSON---------------------------
loblaws_urls.each_with_index do |product, index|
  html = return_html_page_source(product)
  scrape_product_details(html)
  save_scraped_data_to_json(keyvalues[index], "loblaws_products.json")
  @products = []
end
# html = return_html_page_source("https://www.maxi.ca/en/search?search-bar=Orange+juice")
# scrape_product_details(html)
# save_scraped_data_to_json("OrangeJuice", "orange_juice_from_maxi.json")
# puts "Total items scraped: #{@counter}"
