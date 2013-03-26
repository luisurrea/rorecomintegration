class Admin::SliderimagesController < Admin::BaseController

  def index
    @images = Sliderimage.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  def show
   @image = Sliderimage.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image}
    end
  end

  def new
    @image = Sliderimage.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image}
    end
  end

  def edit
    @image = Sliderimage.find(params[:id])
  end

  def create
    @image = Sliderimage.new(params[:sliderimage])
    respond_to do |format|
      if @image.save
        format.html { redirect_to admin_sliderimages_url, notice: 'La imagen se creo correctamente.' }
        format.json { render json: @image, status: :created, location: @image}
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @image=  Sliderimage.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:sliderimage])
        format.html { redirect_to admin_sliderimages_url, notice: 'La imagen se actualizo correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image = Sliderimage.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html { redirect_to admin_sliderimages_url }
      format.json { head :no_content }
    end
  end
end
