class ProductsController < ApplicationController
  def index
    @product_prices = ProductPrice.all
    sort_order = params[:sort_order] || "asc"
    if params[:query].present?
      @product_prices = @product_prices.search_by_name_and_brand(params[:query])
      @product_prices = @product_prices.group_by { |p| p.product_id }.map { |_product_id, prices| prices.first }
      @product_prices = @product_prices.sort_by { |p| p.price }
      @product = @product_prices[0]
    end
    if params[:sort_by] == "price"
    @product_prices = @product_prices.sort_by { |p| p.price }
    @product_prices.reverse! if sort_order == "desc"
    end
    if params[:sort_by] == "price_per_100_unit"
      @product_prices = @product_prices.sort_by { |p| p.product.price_per_100_unit }
      @product_prices.reverse! if sort_order == "desc"
    end
  end
end
