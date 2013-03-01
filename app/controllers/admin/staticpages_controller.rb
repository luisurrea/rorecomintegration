class Admin::StaticpagesController < Admin::BaseController
  
 # GET /products
  # GET /products.json
  def index
    @pages = Staticpage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
   @page = Staticpage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @page = Staticpage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page}
    end
  end

  # GET /products/1/edit
  def edit
    @page = Staticpage.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @page = Staticpage.new(params[:staticpage])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @page =  Staticpage.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:staticpage])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @page = Staticpage.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to admin_staticpages_url }
      format.json { head :no_content }
    end
  end
end
