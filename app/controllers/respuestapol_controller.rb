class RespuestapolController < ApplicationController
  def index
   if params.nil?
     redirect_to root_path
   else 
     @estado=txstatus(params[:codigo_respuesta_pol], params[:estado_pol])
   end
  end
  private
  def txstatus(codigo_respuesta_pol, estado_pol)
     @estadotx=nil
     if(estado_pol == "6" && codigo_respuesta_pol == "5")
       @estadotx = "Transaccion fallida"
     elsif(estado_pol == "6" && codigo_respuesta_pol == "4")
       @estadotx = "Transaccion rechazada"
     elsif(estado_pol == "12" && codigo_respuesta_pol == "9994")
       @estadotx = "Pendiente, Por favor revisar si el debito fue realizado en el Banco"
     elsif(estado_pol == "4" && codigo_respuesta_pol== "1")
       @estadotx = "Transaccion aprobada"
     end
     return @estadotx
   end
  
end