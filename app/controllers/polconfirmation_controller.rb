class PolconfirmationController < ApplicationController
  
  def index
      if params[:firma]
           @order.credited_amount = 12345
           @order.save
        
      end
      
  end
  
end