class ProductsController < ApplicationController
 # skip_before_action :authenticate_user!

  def index
    @products = Product.all
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR brand ILIKE :query"
      @products = @products.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def search
  end
end
