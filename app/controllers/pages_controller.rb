class PagesController < ApplicationController

def home
  @products = Product.includes(:stores, :product_prices).order("RANDOM()").limit(3).all
  if params[:query].present?
    @products = Product.search_by_name_and_brand(params[:query])
  end
end

  def preferences
  end

  def update_preferences
  end
end
