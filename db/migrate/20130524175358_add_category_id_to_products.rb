class AddCategoryIdToProducts < ActiveRecord::Migration
  def up
    add_column :products, :category_id, :integer
    add_index :products, :category_id
  end

  def down
    remove_column :products, :category_id
  end
end
