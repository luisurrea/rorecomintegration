class ProductsController < ApplicationController

  def index
    products = Product.active.includes(:variants)
    product_types = nil
    @noproducttype=false
    @haschildren=false
    @categbreadcrumb=""
    if params[:product_type_id].present?
      @children = ProductType.where('parent_id = ?', params[:product_type_id])
      if @children.empty?
        @haschildren=false
        product_type = ProductType.find_by_id(params[:product_type_id]) 
        @parent=ProductType.where('id = ?', product_type.parent_id).pluck(:name)
        product_types = product_type.self_and_descendants.map(&:id)
        params[:page] ||= 1
        @products = products.where('product_type_id IN (?)', product_types || featured_product_types).
                           paginate(:per_page => 20, :page => params[:page].to_i)
        if @parent.empty?
          @categbreadcrumb=product_type.name
        else
          @categbreadcrumb=@parent[0]+" - "+product_type.name
        end          
      else
        @haschildren=true
        @products = products.where('product_type_id IN (?)', @children)
        @parent=ProductType.where('id = ?', @children[0].parent_id).pluck(:name)
        @categbreadcrumb=@parent[0]
      end
    else 
      product_types = ProductType.where('parent_id is NULL')
      @children=product_types
      @noproducttype=true
      @products = products.where('product_type_id = ?', params[:product_type_id])
      @categbreadcrumb="Categorias de Productos"
    end  
  end

  def create

    pagination_args = {}
    pagination_args[:page] = params[:page] || 1
    pagination_args[:rows] = params[:rows] || 15

    if params[:q] && params[:q].present?
      @products = Product.standard_search(params[:q], pagination_args).results
    else
      @products = Product.where('deleted_at IS NULL OR deleted_at > ?', Time.zone.now )
    end

    render :template => '/products/index'
  end

  def show
    @product = Product.active.find(params[:id])
    form_info
  end

  private

  def form_info
    @cart_item = CartItem.new
  end

  def featured_product_types
    [ProductType::FEATURED_TYPE_ID]
  end
end
