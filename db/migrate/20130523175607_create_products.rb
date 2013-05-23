class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :slug
      t.references :brand
      t.string :name
      t.string :type
      t.integer :price
      t.text :options
      t.text :features
      t.text :design
      t.text :description
      t.string :slogan

      t.timestamps
    end
    add_index :products, :brand_id
  end
end
