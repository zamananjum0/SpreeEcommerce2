module Spree
  module Admin
    class NavigationsController < Spree::Admin::BaseController
      def index
        @navigations = Spree::Admin::Navigation.all
      end
    end
  end
end

