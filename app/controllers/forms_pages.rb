class FormsPagesController < ApplicationController
  def new
    @contactmsg = Contactmsg.new
  end
  
  def create 
    @contactmsg = Contactmsg.new(params[:contactmsg])
    if @contactmsg.valid?
      flash[:notice] = 'Mensaje enviado, gracias por contactarnos'
      redirect_to root_url
      else
      render :action => 'new'
     end
    end
end
