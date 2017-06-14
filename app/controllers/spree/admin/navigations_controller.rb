module Spree
  module Admin
    class NavigationsController < ResourceController
      before_action :to_slug, only: [:update, :create]

      private

      def location_after_save
        if @navigation.created_at == @navigation.updated_at
          edit_admin_navigation_url(@navigation)
        else
          admin_navigations_url
        end
      end

      def to_slug
        params[:slug] = params[:name].parameterize if params[:name].present?
      end
    end
  end
end
