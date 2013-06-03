class RenameParentToParentId < ActiveRecord::Migration
  def up
    rename_column :categories, :parent, :parent_id
  end

  def down
    rename_column :categories, :parent_id, :parent
  end
end
