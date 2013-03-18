class ContactusController < ApplicationController
  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(params[:message])
    
    if @message.valid?
      Notifier.contact_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end

end