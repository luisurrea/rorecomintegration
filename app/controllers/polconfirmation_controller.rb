class PolconfirmationController < ApplicationController
  
  def index
      if params[:firma]
        @order = Order.where('polid = ? ', params[:refVenta])
        if @order.nil?
          redirect_to root        
        else 
          if params[:firma]==Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.get_refventa+"~"+@order.total.to_s+"~"+POLMONEDA+"~"+params[:estado_pol])
            
          end
        end
        
      else 
        redirect_to root_path
      end
      
  end
  
end