class Crumb
  def initialize(item, params)
    @item = item
    @params = params
  end

  def name
    name = defined?(@item.name) ? @item.name : @item.title
  end

  def home?
    @item.is_a?(Page) && @item.slug == 'home'
  end

  def page?
    @item.is_a? Page
  end

  def product?
    @item.is_a? Product
  end

  def brand?
    @item.is_a? Brand
  end

  def subcategory?
    @item.is_a?(Category) && @item.slug == params[:subcategory]
  end

  def category?
    @item.is_a?(Category) && @item.slug == params[:category]
  end

  private

  attr_reader :params
end