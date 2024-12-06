class PagesController < ApplicationController
  # before_action :authenticate_user!, only: [:home]

  def home
    @products = []
    if params[:query].present?
      @products = Product.search_by_name_and_brand(params[:query])
    end
  end

  def preferences
  end

  def update_preferences
  end
end
