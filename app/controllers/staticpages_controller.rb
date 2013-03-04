class StaticpagesController < ApplicationController
  def home
  end
  def empresa
     @page = Staticpage.where('name = ?', 'Empresa')
  end
  def terms
    @page = Staticpage.where('name = ?', 'Terminos y Condiciones')
  end
  def conozca_tramontina
    @page = Staticpage.where('name = ?', 'Conozca Tramontina')
  end
  def videos_y_recetas
    @page = Staticpage.where('name = ?', 'Videos y Recetas')
  end
end