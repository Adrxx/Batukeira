class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :admin_permission, only: [:index, :new, :create, :destroy, :update]

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
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'Se han guardado los cambios.'
        format.html { redirect_to users_path }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    flash[:warning] = "Se ha destruído el usuario: #{@user.name}"
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

    def admin_permission
      if current_user.role == "capturist"
        flash[:warning] = "No tiene permiso para realizar esta acción."
        redirect_to admin_path
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
