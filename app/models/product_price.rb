class ProductPrice < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :price, presence: true
  # validates :scraping_date, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_name_and_brand,
                   associated_against: { product: %i[name brand] }

  def percentage(data)
    lowest_product = data[:pp]
    lowest_price = lowest_product.price.delete('$').to_f
    match = lowest_product.product.price_per_100_unit.match(/\$([0-9]*\.?[0-9]+)\/([0-9]+)(\w+)/)
    price = match[1].to_f
    quantity = match[2].to_i
    unit = match[3]
    initial_value = lowest_price
    final_value = data[:final_value]
    associated_value = price
    percentage_increase = ((final_value - initial_value) / initial_value) * 100
    x = (associated_value * (1 + (percentage_increase / 100))).round(2)
    hash = {
      price: final_value,
      lowest_price: x,
      quantity: quantity,
      unit: unit
    }
    return hash
  end

  def average_price
    pp = ProductPrice.where(product: product, store: store)
    sum = 0
    pp.each do |data|
      sum += data.price.delete('$').to_f
    end
    hash = {
      pp: pp.first,
      final_value: (sum / pp.size).round(2)
    }
    # data = percentage(hash)
    return percentage(hash)

  end

  ####################################################################################
  # These methods will only work that way because of the way we implement our seeds.
  # For the future, it will be beneficial to make changes to these methods.
  ####################################################################################

  def highest_price
    # highest_price_product = pp.max_by do |product|
    # product.price
    # end
    pp = ProductPrice.where(product: product, store: store)
    highest_price_product = pp.last
    hash = {
      pp: pp.first,
      final_value: highest_price_product.price.delete('$').to_f
    }

    data = percentage(hash)
    return data
  end

  def lowest_price
    # highest_price_product = pp.min_by do |product|
    #   product.price
    # end
    pp = ProductPrice.where(product: product, store: store)
    highest_price_product = pp.first
    return highest_price_product.price
  end

  def data_for_graph
    pp = ProductPrice.where(product: product, store: store)
    data = pp[1..].map do |d|
      d.price.delete('$').to_f
    end
    data = data.shuffle
    data << pp[0].price.delete('$').to_f
    return data
  end
end
