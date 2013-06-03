class AddParentCategoryToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :parent, :integer
  end

  def down
    remove_column :categories, :parent
  end
end
