class PolconfirmationController < ApplicationController
  
  def index
      if params[:firma]
        @order = Order.find_by_polid(params[:refVenta])
        
           @order.credited_amount = 12345
           @order.save
           
           #flash[:alert] = 'las firmas coinciden'
           #else
             #flash[:alert] = "No coinciden"
        
        
        
       
        #flash[:alert] = 'no llego parametro de firma'
      end
      
  end
  
end