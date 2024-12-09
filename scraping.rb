require 'selenium-webdriver'
require 'nokogiri'
require "json"

# VARIABLES
@counter = 0
@products = []
# ----------------------------------------------

# METHODS
def return_html_page_source(url)
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  # Initialize the WebDriver for Chrome with the specified options
  driver = Selenium::WebDriver.for :chrome, options: options
  driver.get(url)
  sleep 15
  html = driver.page_source
  return html
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
  json_output = { key_value => @products }
  File.open(file_path, "wb") do |file|
    file.write(JSON.generate(json_output))
  end
end

# EXAMPLES OF HOW TO USE METHODS

# ------------------------TO SAVE DOM LOCALLY--------------------------------
# html = return_html_page_source("https://www.provigo.ca/en/search?search-bar=Orange%20juice")
# save_dom_to_local(html, "orange_juice.html")

# -------------------TO SCRAPE FROM SAVED HTML---------------------------
# scrape_from_saved_html_file("orange_juice.html")

# -------------------TO SCRAPE AND SAVE TO JSON---------------------------
# html = return_html_page_source("https://www.maxi.ca/en/search?search-bar=Orange+juice")
# scrape_product_details(html)
# save_scraped_data_to_json("OrangeJuice", "orange_juice_from_maxi.json")
# puts "Total items scraped: #{@counter}"
