class PolconfirmationController < ApplicationController
  
  def index
      if params[:firma]
        @order = Order.where('polid = ? ', params[:refVenta])
        if @order.empty?
          redirect_to root        
          flash[:alert] = 'no existe la orden'
        else 
          if params[:firma]==Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.polid+"~"+@order.totalorder.to_s+"~"+POLMONEDA+"~"+params[:estado_pol])
            @order.credited_amount = 12345
            @order.save
          end
        end
        
      else 
        redirect_to root_path
        flash[:alert] = 'no llego parametro de firma'
      end
      
  end
  
end