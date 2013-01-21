class Customer::RegistrationsController < ApplicationController
  def new
    @registration = true
    @user         = User.new
    @user_session = UserSession.new
    render :template => 'customer/registrations/register'
  end

  def create
    @user = User.new(params[:user])
    @user.format_birth_date(params[:user][:birth_date]) if params[:user][:birth_date].present?
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      UserSession.new(@user.attributes)
      flash[:notice] = "Su cuenta ha sido creada, por favor verifique su email para ver las instrucciones de activacion"
      redirect_to root_url
    else
      @registration = true
      @user_session = UserSession.new
      render :template => 'customer/registrations/register'
    end
  end

end
