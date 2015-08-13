class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :only_admin_permission, only: [:index, :new, :create, :destroy] #Capturist cannot call these
  before_action :only_itself_permission, only: [:edit, :update] #Capturist can edit/update its own user only
  


  layout 'admin'

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.auth_password_invalid = auth_password_invalid?
    respond_to do |format|
      if @user.save
        flash[:success] = 'Se han guardado los cambios.'
        format.html { redirect_to users_path }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.auth_password_invalid = auth_password_invalid?
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'Se han guardado los cambios.'
        format.html do
          if current_user.role == "admin"
            redirect_to users_path
          else
            redirect_to edit_user_path(current_user)
          end
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    flash[:warning] = "Se ha destruído el usuario: #{@user.email}"
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def only_admin_permission
      if current_user.role != "admin"
        flash[:warning] = "No tiene permiso para realizar esta acción."
        redirect_to edit_user_path(current_user)
      end
    end

    def only_itself_permission
      #Only allow capturist to edit its own account, Admins can edit all
      if current_user.role == "capturist"
        if current_user != @user
          flash[:warning] = "No tiene permiso para realizar esta acción."
          redirect_to edit_user_path(current_user)
        end
      end
    end

    def auth_password_invalid?
      !current_user.valid_password?(params[:user][:auth_password])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
