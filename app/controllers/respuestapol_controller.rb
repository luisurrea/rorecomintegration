class RespuestapolController < ApplicationController
  def index
    if params[:usuario_id]==POLID
      @fecha_procesamiento=params[:fecha_procesamiento]
      @estadoTx= params[:estado]
      @ref_venta= params[:ref_venta]
      @ref_pol= params[:ref_pol]
      @valor= params[:valor]
      @moneda= params[:moneda]
      @extra1= params[:extra1]
    end
  end
end