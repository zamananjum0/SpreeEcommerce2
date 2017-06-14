class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :main_navigation

  def main_navigation
    @main_navigations = Spree::Navigation.all.order(position: :asc)
  end
end
