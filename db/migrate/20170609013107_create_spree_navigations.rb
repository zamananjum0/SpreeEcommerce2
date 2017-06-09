class CreateSpreeNavigations < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_navigations do |t|
      t.string :name
      t.string :slug
      t.string :link, null: true
      t.string :class, null: true
      t.string :html_before, null: true
      t.integer :position, default: 0

      t.timestamps
    end
    add_index :spree_navigations, :position, name: 'add_index_position'
  end
end
