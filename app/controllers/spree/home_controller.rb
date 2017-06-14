# Spree::HomeController.class_eval do
module Spree
  class HomeController < StoreController
    helper 'spree/products'
    respond_to :html
    def index
      @searcher = build_searcher(params.merge(include_images: true))
      sorting_scope = params[:sorting].try(:to_sym) || :descend_by_updated_at
      @products = @searcher.retrieve_products.send(sorting_scope)
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end
  end
end
# end
