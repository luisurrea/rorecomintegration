class PolconfirmationController < ApplicationController
  
  def index
      if params[:ref_venta]
        @order = Order.find_by_polid(params[:ref_venta])
        unless @order.nil?
          if params[:firma].eql? Digest::MD5.hexdigest(POLKEY+"~"+POLID.to_s+"~"+@order.polid+"~"+@order.totalorder.to_s+"0~"+POLMONEDA+"~"+params[:estado_pol]).upcase
            if params[:estado_pol].eql? '4'
              @order.polstate = txstatus(params[:codigo_respuesta_pol], params[:estado_pol])
              @order.order_complete!
              @order.shipped=true
              @order.save           
            else
              @order.polstate = txstatus(params[:codigo_respuesta_pol], params[:estado_pol])
              @order.save
            end      
          end
        end     
      else
        redirect_to root_path             
      end      
  end
  
  private
  def txstatus(codigo_respuesta_pol, estado_pol)
     @estadotx=nil
     if(estado_pol == "6" && codigo_respuesta_pol == "5")
       @estadotx = "Transaccion fallida"
     elsif(estado_pol == "6" && codigo_respuesta_pol == "4")
       @estadotx = "Transaccion rechazada por la entidad"
     elsif(estado_pol == "6" && codigo_respuesta_pol == "23")
       @estadotx = "Transaccion rechazada"
     elsif(estado_pol == "7" && codigo_respuesta_pol == "15")
       @estadotx = "Transaccion en proceso de validacion"  
     elsif(estado_pol == "12" && codigo_respuesta_pol == "9994")
       @estadotx = "Pendiente, Por favor revisar si el debito fue realizado en el Banco"
     elsif(estado_pol == "4" && codigo_respuesta_pol== "1")
       @estadotx = "Transaccion aprobada"
     end
     return @estadotx
   end
  
end