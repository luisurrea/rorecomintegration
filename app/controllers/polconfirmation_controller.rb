class PolconfirmationController < ApplicationController
  
  def index
      if params[:firma]
        @order = Order.find_by_polid(params[:refVenta])
        if @order.nil?
          redirect_to root_path      
          flash[:alert] = 'no existe la orden'
        else
          if params[:firma]==Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.polid+"~"+@order.totalorder.to_s+"~"+POLMONEDA+"~"+params[:estado_pol])
           redirect_to root_path      
           flash[:alert] = 'las firmas coinciden'
           else
             flash[:alert] = "firma parametro: "+params[:firma]+"  firma guardada:"+Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.polid+"~"+order.totalorder.to_s+"~"+POLMONEDA+"~"+params[:estado_pol])
          end
        end
        
      else 
        redirect_to root_path
        flash[:alert] = 'no llego parametro de firma'
      end
      
  end
  
end