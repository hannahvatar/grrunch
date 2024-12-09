require 'selenium-webdriver'
require 'nokogiri'
require "json"

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')  # Run in headless mode (no UI). This allows the browser to run in the background without opening a visible window

# Initialize the WebDriver for Chrome with the specified options
driver = Selenium::WebDriver.for :chrome, options: options

# Navigate to the specified URL
# url = 'https://www.scrapingcourse.com/javascript-rendering'
# url = "https://www.provigo.ca/en/search?search-bar=Orange%20juice"
# url = "https://www.provigo.ca/en/search?search-bar=Chocolate%20chips%20cookies"
# url = "https://www.provigo.ca/en/search?search-bar=Water"
# url = "https://www.provigo.ca/en/search?search-bar=Wine"
# url = "https://www.provigo.ca/en/search?search-bar=Yogurt"
# url = "https://www.provigo.ca/en/search?search-bar=Strawberries"
url = "https://www.provigo.ca/en/search?search-bar=ground%20beef"
# water, wine, yogurt, strawberries, ground_beef, chocolate_chips_cookies

driver.get(url)

# Wait for the page to fully load
sleep 15

# Get the page source

html = driver.page_source
# doc = Nokogiri::HTML(html)

# file_path = 'chocolate_chips_cookies.html'

# File.open(file_path, 'w') do |file|
#   file.write(doc)
# end

# driver.quit
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
      puts "Product name: #{product_name}"
      puts "Brand: #{brand}"
      puts "Price: #{price}"
      puts "Weight: #{weight}"
      puts "Price per 100unit: #{price_per_100_unit}"
      puts "image_URL: #{img_url}"
      puts "------------------"
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
# html_content = File.read('chocolate_chips_cookies.html')

scrape_product_details(html)

json_output = { GroundBeef: @products }
File.open("ground_beef.json", "wb") do |file|
  file.write(JSON.generate(json_output))
end

puts "---------------------"
puts "Total items scraped: #{@counter}"
puts "Number of pages: #{@pages}"



# grid = product-grid
# image = product-image
# price = price-product-tile
# brand = product-brand
# product_name = product-title
# weight = product-package-size
# sponsored = product-badge
# regular-price
# price-descriptor #SAVE 0.50 $
# sale-price #6.99
# was-price #7.49
# non-members-price
