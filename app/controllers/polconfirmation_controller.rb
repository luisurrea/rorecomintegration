class PolconfirmationController < ApplicationController
  
  def index
      if params[:firma]
        @order = Order.where("polid LIKE ?", "#{params[:email]}%")
        if @order.empty?
          redirect_to root_path      
          flash[:alert] = 'no existe la orden'
        else
          redirect_to root_path  
          flash[:alert] = @order
        end
        
      else 
        redirect_to root_path
        flash[:alert] = 'no llego parametro de firma'
      end
      
  end
  
end