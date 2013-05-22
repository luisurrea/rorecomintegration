class PolconfirmationController < ApplicationController
  
  def index
      if params[:ref_venta]
        @order = Order.find_by_polid(params[:ref_venta])
        @order.polid=Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.polid+"~"+@order.totalorder.to_s+"0~"+POLMONEDA+"~"+params[:estado_pol]).upcase.strip+"~"+params[:firma]
        @order.save
        if Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.polid+"~"+@order.totalorder.to_s+"0~"+POLMONEDA+"~"+params[:estado_pol]).upcase.strip == params[:firma].to_s
          @order.order_complete!
          @order.save
        end     
      else
        redirect_to root_path             
      end      
  end
  
end