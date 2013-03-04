class StaticpagesController < ApplicationController
  def home
  end

  def empresa
    
    @page = Staticpage.where('name = ?', 'Empresa')
  end

  def terms
  end
   
   def conozca_tramontina
     
   end
end