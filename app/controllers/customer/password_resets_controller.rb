class Customer::PasswordResetsController < ApplicationController

    before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

    def new
      @user = User.new
      #render
    end

    def create
        @user = User.find_by_email(params[:user][:email])
        if @user
          @user.deliver_password_reset_instructions!
          flash[:notice] = 'Las instrucciones para restablecer la contrasena fueron enviadas a su direccion de correo.'
          render :template => '/customer/password_resets/confirmation'
        else
          @user = User.new
          flash[:notice] = I18n.t('No_user_was_found_with_that_email_address')
          render :action => 'new'
        end
    end

    def edit
      #render
    end

    def update
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        #@user.activate!
        flash[:notice] = 'su contrasena fue restablecida.'
        redirect_to root_path
      else
        render :action => :edit
      end
    end

    protected

    def load_user_using_perishable_token
      @user = User.find_by_perishable_token( params[:id])
      flash[:notice] = 'Este enlace no funcionara mas, si pierde sus datos tiene que restablecer su contrasena nuevamente.'
      redirect_to login_url and return unless @user
    end

end
