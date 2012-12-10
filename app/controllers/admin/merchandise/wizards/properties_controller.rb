class Admin::Merchandise::Wizards::PropertiesController < Admin::Merchandise::Wizards::BaseController
  def index
    form_info
  end

  def create
    property = Property.new(params[:property])
    flash[:notice] = "Propiedad creada satisfactoriamente." if property.save
    form_info
    render :action => 'index'
  end

  def update
    if params[:property] &&  valid_property_ids
      session[:product_wizard] ||= {}
      session[:product_wizard][:property_ids] = params[:property][:ids].map(&:to_i)
      flash[:notice] = "Propiedades agregadas satisfactoriamente."
      redirect_to next_form
    else
      flash[:notice] = "Por favor seleccione al menos una propiedad."
      form_info
      render :action => 'index'
    end
  end

  private

  def valid_property_ids
    params[:property][:ids] && !params[:property][:ids].empty? && params[:property][:ids].all? {|id| Property.find_by_id(id) }
  end

  def form_info
    @prototypes ||= Prototype.all
    @properties ||= Property.all
    @property ||= Property.new
    @selected ||= session[:product_wizard][:property_ids] || []
  end
end
