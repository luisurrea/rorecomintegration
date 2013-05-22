class PolconfirmationController < ApplicationController
  
  def index
      if params[:ref_venta]
        @order = Order.find_by_polid(params[:ref_venta])
        unless @order.nil?
          @order.order_complete!
          @order.save
        end     
      else
        redirect_to root_path             
      end      
  end
  
end