class ContactusController < ApplicationController
  def new
    @message = Contactus.new
  end

  def create
    @message = Contactus.new(params[:contactus])
    
    if @message.valid?
      Notifier.contact_message(@message).deliver
      redirect_to(root_path, :notice => "Su mensaje fue enviado.")
    else
      flash.now.alert = "Por favor llene todos los campos."
      render :new
    end
  end

end