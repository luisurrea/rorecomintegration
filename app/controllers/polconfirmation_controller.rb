class PolconfirmationController < ApplicationController
  
  def index
      if params[:ref_venta]
        @order = Order.find_by_polid(params[:ref_venta])
        @order.polid='yes'
        @order.save
        if params[:firma]==Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.polid+"~"+@order.totalorder.to_s+"~"+POLMONEDA+"~"+params[:estado_pol])
          @order.order_complete!
          @order.save
        end     
      else
        redirect_to root_path             
      end      
  end
  
end