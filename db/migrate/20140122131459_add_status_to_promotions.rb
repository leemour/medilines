class AddStatusToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :status, :string
  end
end
