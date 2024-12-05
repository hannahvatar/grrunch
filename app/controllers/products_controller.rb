class ProductsController < ApplicationController
 # skip_before_action :authenticate_user!

  def index
    @products = Product.all
    if params[:query].present?
      @products = Product.search_by_name_and_brand(params[:query])
    end
  end

  def search
  end
end
