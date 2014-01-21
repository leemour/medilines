class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :slug
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
