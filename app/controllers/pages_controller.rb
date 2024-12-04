class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
  end

  def preferences
  end

  def update_preferences
  end
end
