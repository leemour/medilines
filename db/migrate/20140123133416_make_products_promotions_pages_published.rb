class MakeProductsPromotionsPagesPublished < ActiveRecord::Migration
  def change
    %w[Product Promotion Page].each do |model|
      model.constantize.unscoped.update_all status: 'published'
    end
  end
end
