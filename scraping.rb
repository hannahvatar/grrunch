require 'selenium-webdriver'
require 'nokogiri'
require "json"

# options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')  # Run in headless mode (no UI). This allows the browser to run in the background without opening a visible window

# Initialize the WebDriver for Chrome with the specified options
# driver = Selenium::WebDriver.for :chrome, options: options

# Navigate to the specified URL
# url = 'https://www.scrapingcourse.com/javascript-rendering'
# url = "https://www.provigo.ca/en/search?search-bar=Orange%20juice"
# url = "https://www.provigo.ca/en/search?search-bar=Chocolate%20chips%20cookies"
# url = "https://www.provigo.ca/en/search?search-bar=Water"
# url = "https://www.provigo.ca/en/search?search-bar=Wine"
# url = "https://www.provigo.ca/en/search?search-bar=Yogurt"
# url = "https://www.provigo.ca/en/search?search-bar=Strawberries"
# url = "https://www.provigo.ca/en/search?search-bar=ground%20beef"
# url = "https://www.loblaws.ca/search?search-bar=Chocolate%20chips%20cookies"
# water, wine, yogurt, strawberries, ground_beef, chocolate_chips_cookies

# driver.get(url)

# Wait for the page to fully load
# sleep 15

# Get the page source

# html = driver.page_source
# doc = Nokogiri::HTML(html)

# file_path = 'chocolate_chips_cookies.html'

# File.open(file_path, 'w') do |file|
#   file.write(doc)
# end

def display_on_console(data)
  puts "Product name: #{data[:product_name]}"
  puts "Brand: #{data[:brand]}"
  puts "Price: #{data[:price]}"
  puts "Weight: #{data[:weight]}"
  puts "Price per 100unit: #{data[:price_per_100_unit]}"
  puts "image_URL: #{data[:img_url]}"
  puts "------------------"
end


@counter = 0
@pages = 0
@products = []
def scrape_product_details(html)
  @pages += 1
  doc = Nokogiri::HTML(html)

  products = doc.css(".css-1tjthuk")

  products.each do |product|

    items = product.css('.css-0')
    items.each do |item|
      sponsored = item.at_css("[data-testid='product-badge']")&.text&.strip
      next if sponsored == "Sponsored"

      product_name = item.at_css("[data-testid='product-title']")&.text&.strip
      img_url = item.at_css('div[data-testid="product-image"] img')&.[]('src')
      brand = item.at_css("[data-testid='product-brand']")&.text&.strip

      regular_price = item.at_css("[data-testid='regular-price']")&.text&.strip
      non_members_price = item.at_css("[data-testid='non-members-price']")&.text&.strip
      sale_price = item.at_css("[data-testid='sale-price']")&.text&.strip
      # Extract only the price portion, ignoring "sale" or "about"
      if sale_price
        price_match = sale_price.match(/\$[\d.,]+/)
        sale_price = price_match[0] if price_match
      end
      was_price = item.at_css("[data-testid='was-price']")&.text&.strip

      if !regular_price.nil?
        price = regular_price
      elsif !non_members_price.nil? && !sale_price.nil?
        price = non_members_price
      elsif !sale_price.nil? && !was_price.nil?
        price = sale_price
      end
      # price = item.at_css("[data-testid='price-product-tile']")&.text&.strip

      weight_info = item.at_css("[data-testid='product-package-size']")&.text&.strip
      weight = nil
      price_per_100_unit = nil

      if weight_info
        weight_match = weight_info.match(/^([\d.x]+(?:\s?[a-zA-Z]+)?)\b/)
        price_match = weight_info.match(/\$[\d.]+\/\d+[a-zA-Z]+$/)

        weight = weight_match[1] if weight_match
        price_per_100_unit = price_match[0] if price_match
      end
      next if product_name.nil? || brand.nil? || price.nil? || weight.nil? || img_url.nil? || price_per_100_unit.nil?

      hash = {
        product_name:,
        brand:,
        price:,
        weight:,
        price_per_100_unit:,
        img_url:
      }
      @products << hash
      display_on_console(hash)
      @counter += 1
    end
  end
  # Handle pagination

  # Check for the presence of a "Next page" link
  next_page_link = doc.at_css('a[aria-label="Next Page"]')
  puts next_page_link
  if next_page_link
    # Recursively scrape the next page
    next_url = next_page_link['href']
    driver.get(next_url)
    sleep 10
    html = driver.page_source
    scrape_product_details(html)
  end
end

# Load the content of the saved HTML file
html_content = File.read('chocolate_chips_cookies.html')

scrape_product_details(html_content)

# json_output = { ChocolateChipsCookies: @products }
# File.open("cookies_loblaws.json", "wb") do |file|
#   file.write(JSON.generate(json_output))
# end

puts "---------------------"
puts "Total items scraped: #{@counter}"
puts "Number of pages: #{@pages}"
