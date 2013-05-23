class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :country
      t.string :slogan
      t.text :description
      t.string :logo
      t.string :image
      t.string :flag

      t.timestamps
    end
  end
end
