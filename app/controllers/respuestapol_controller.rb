class RespuestapolController < ApplicationController
  def index
    if params[].present?
      @usuario_id=params[:usuario_id]
    end
  end
end