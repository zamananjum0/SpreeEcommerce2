module Spree
  module Admin
    class NavigationsController < ResourceController
      before_action :to_slug, only: [:update, :create]
      private

        def to_slug
          params[:slug] = params[:name].parameterize if params[:name].present?
        end
    end
  end
end
