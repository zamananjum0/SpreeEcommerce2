module Spree
  class Navigation < ActiveRecord::Base
    acts_as_list # Update position
    default_scope { order(position: :asc) }
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :slug, uniqueness: { case_sensitive: false }
  end
end