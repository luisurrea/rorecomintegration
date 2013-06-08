class ContactusController < ApplicationController
  def new
    @message = Contactus.new
  end

  def create
    @message = Contactus.new(params[:contactus])
    
    if @message.valid?
      Notifier.contact_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end

end