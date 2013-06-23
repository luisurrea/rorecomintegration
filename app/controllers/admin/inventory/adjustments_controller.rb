class Admin::Inventory::AdjustmentsController < Admin::BaseController
  def show
    @product = Product.includes(:variants).find(params[:id])
  end

  def index
    if params[:name].present?
        params[:page] ||= 1
        params[:rows] ||= 20
        @products = Product.where('name LIKE ?', '%'+params[:name]+'%').
                                              paginate(:per_page => 25, :page => params[:page].to_i)
    elsif params[:product_type_id].present?
        params[:page] ||= 1
        params[:rows] ||= 20
        @products = Product.where('product_type_id LIKE ?', params[:product_type_id]).
                                              paginate(:per_page => 25, :page => params[:page].to_i)
    
    elsif params[:sku].present?
       params[:page] ||= 1
       @variant = Variant.where('sku LIKE ?', '%'+params[:sku]+'%')
       if @variant.empty?
          @products = Product.where('name LIKE ?', params[:name]).
                                                paginate(:per_page => 25, :page => params[:page].to_i)
       else
          @variant.each do |var|
            @products = Product.where('id = ?', var.product_id).paginate(:per_page => 25, :page => params[:page].to_i)
          end
       end
    else    
        params[:page] ||= 1
        params[:rows] ||= 20
        @products = Product.paginate({:page => params[:page].to_i,:per_page => params[:rows].to_i})
    end    
  end

  def edit
    form_info
    @variant = Variant.includes(:product).find(params[:id])
  end

  def update
    @variant = Variant.find(params[:id])
    ###  the reason will effect accounting
    #    if the item is refunded by the supplier the accounting will be reflected
    if params[:refund].present? && params[:variant][:qty_to_add].present?
      if params[:refund].to_f > 0.0
        AccountingAdjustment.adjust_stock(@variant.inventory, params[:variant][:qty_to_add].to_i, params[:refund].to_f)
        flash[:notice] = "Inventario actualizado."
        redirect_to admin_inventory_adjustment_url(@variant.product)
      elsif @variant.update_attributes(params[:variant])
        flash[:notice] = "Inventario actualizado."
        redirect_to admin_inventory_adjustment_url(@variant.product)
      else
        form_info
        render :action => 'edit', :id => params[:id]
      end
    else
      flash[:alert] = "Refund must be entered (fill in 0 for no refund)." unless params[:refund].present?
      form_info
      render :action => 'edit', :id => params[:id]
    end
  end

  private

  def form_info

  end
end

