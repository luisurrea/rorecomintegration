class PolconfirmationController < ApplicationController
  
  def index
      if params[:firma]
        @order = Order.find_by_polid(params[:refVenta])
        if @order.nil?
          #flash[:alert] = 'no existe la orden'
        else
          if params[:firma]==Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.polid+"~"+@order.totalorder.to_s+"~"+POLMONEDA+"~"+params[:estado_pol])
           @order.credited_amount = 12345
           @order.save
           
           #flash[:alert] = 'las firmas coinciden'
           #else
             #flash[:alert] = "No coinciden"
          end
        end
        
      else 
        #flash[:alert] = 'no llego parametro de firma'
      end
      
  end
  
end