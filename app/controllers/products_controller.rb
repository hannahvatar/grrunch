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
    @products = Product.includes(:stores, :product_prices)
    if params[:query].present?
    @products = @products.search_by_name_and_brand(params[:query])
    end
  end
end

# && ProductPrice.search_by_price(params[:querry])
