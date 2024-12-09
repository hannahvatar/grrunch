class ProductsController < ApplicationController
 # skip_before_action :authenticate_user!

  def index
    @products = Product.all
    @prices = ProductPrice.all
    if params[:query].present?
      @products = Product.search_by_name_and_brand(params[:query])
      @prices = ProductPrice.search_by_price(params[:query])
    end
  end

end

# && ProductPrice.search_by_price(params[:querry])
