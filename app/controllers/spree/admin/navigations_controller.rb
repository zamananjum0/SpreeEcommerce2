module Spree
  module Admin
    class NavigationsController < ResourceController

      def index
        session[:return_to] = request.url
        respond_with(@collection)
      end

      def new
      end

    end
  end
end

