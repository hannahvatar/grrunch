# class ProductsController < ApplicationController
 # skip_before_action :authenticate_user!

#  def index
#   @products = Product.all
#    if params[:query].present?
#      @products = Product.search_by_name_and_brand(params[:query])
#    end
#  end

# end
# products_controller.rb

class ProductsController < ApplicationController
  def index
    @product_prices = ProductPrice.all
    # @products = Product.includes(:stores, :product_prices)
    if params[:query].present?
    @product_prices = @product_prices.search_by_name_and_brand(params[:query])
    @product_prices = @product_prices.group_by { |p| p.product_id }.map { |_product_id, prices| prices.first }
    @product_prices = @product_prices.sort_by { |p| p.price }
    end
    if params[:sort_by] == "price"
    @product_prices = @product_prices.sort_by { |p| p.price }
    end
    if params[:sort_by] == "price_per_100_unit"
      @product_prices = @product_prices.sort_by { |p| p.product.price_per_100_unit }
    end
  end
end
# @product_prices = @product_prices.sort_by { |p| [p.price, p.product.price_per_100_unit] }
