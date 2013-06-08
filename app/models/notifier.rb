class Notifier < ActionMailer::Base
  default :from => "info@inoxdobrasil.com.co"

  # Simple Welcome mailer
  # => CUSTOMIZE FOR YOUR OWN APP
  #
  # @param [user] user that signed up
  # => user must respond to email_address_with_name and name
  def signup_notification(recipient)
    @account = recipient

    #attachments['an-image.jp'] = File.read("an-image.jpg")
    #attachments['terms.pdf'] = {:content => generate_your_pdf_here() }

    mail(:to => recipient.email_address_with_name,
         :subject => "Nueva cuenta en la tienda Inox Do Brasil") do |format|
      format.text { render :text => "Bienvenido  #{recipient.name} ir a #{customer_activation_url(:a => recipient.perishable_token )}" }
      format.html { render :text => "<h1>Bienvenido</h1> #{recipient.name} <a href='#{customer_activation_url(:a => recipient.perishable_token )}'>Haga clic para activar</a>" }
    end

  end

  def password_reset_instructions(user)
    @user = user
    @url  = edit_customer_password_reset_url(:id => user.perishable_token)
    mail(:to => user.email,
         :subject => "Instrucciones para restaurar la contrasena")
  end


  def order_confirmation(order,invoice)
    @invoice = invoice
    @order  = order
    @user   = order.user
    @url    = root_url
    @site_name = 'site_name'
    mail(:to => order.email,
         :subject => "Confirmacion de la orden")
  end
  
  def contact_message(message)
    mail(:to => "luanur@hotmail.com",
         :subject => 'formulario de contacto sitio Inox do Brasil') do |format|
      format.text { render :text => "nombre cliente:  #{message.name} email cliente: #{message.email} mensaje cliente: #{message.body}" }
      format.html { render :text => "<h6>Nuevo mensaje de </h6> #{message.name} <br/> email cliente: #{message.email} <br/> mensaje cliente: #{message.body}" }
      
    end
  end

end
