class PagesController < ApplicationController
  def home
    @products = Product.includes(:stores, :product_prices).order("RANDOM()").limit(6).all
    @trending_lows = Product.order("RANDOM()").limit(24).all
    if params[:query].present?
      @products = Product.search_by_name_and_brand(params[:query])
    end
    @current_page = params[:page]&.to_i || 1
    @products_per_page = 3
    @total_pages = (@products.size.to_f / @products_per_page).ceil

  end

  def preferences
  end

  def update_preferences
  end

  def about
  end
end
