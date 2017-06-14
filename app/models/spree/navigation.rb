module Spree
  class Navigation < ActiveRecord::Base
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :slug, uniqueness: { case_sensitive: false }
  end
end