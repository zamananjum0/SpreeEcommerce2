class CreateSpreeNavigations < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_navigations do |t|
      t.string :name
      t.string :slug
      t.string :link
      t.string :html_class
      t.string :html_before
      t.integer :position

      t.timestamps
    end
    add_index :spree_navigations, :position, name: 'add_index_position'
  end
end
