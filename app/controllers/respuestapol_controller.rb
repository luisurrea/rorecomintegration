class RespuestapolController < ApplicationController
  def index
   if params.nil?
     redirect_to root
   end
  end
end