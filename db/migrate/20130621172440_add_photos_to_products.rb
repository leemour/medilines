class AddPhotosToProducts < ActiveRecord::Migration
  def up
    add_column :products, :photo1, :string
    add_column :products, :photo2, :string
    add_column :products, :photo3, :string
    add_column :products, :photo4, :string
    add_column :products, :photo5, :string
  end
  def down
    remove_column :products, :photo1
    remove_column :products, :photo2
    remove_column :products, :photo3
    remove_column :products, :photo4
    remove_column :products, :photo5
  end
end
