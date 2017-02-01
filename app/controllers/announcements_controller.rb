class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  # GET /cases
  def index
    @cases = Announcement.all
  end

  # GET /cases/1
  def show
  end

  # GET /cases/new
  def new
    @case = Announcement.new
  end

  # GET /cases/1/edit
  def edit
  end

  # POST /cases
  def create
    @case = Announcement.new(case_params)

    if @case.save
      flash[:success] = 'Se han guardado los cambios.'
      redirect_to announcements_path
    else
      render :new
    end
  end

  # PATCH/PUT /cases/1
  def update


    if @case.update(case_params)
      flash[:success] = 'Se han guardado los cambios.'
      redirect_to announcements_path
    else
      render :edit
    end
  end

  # DELETE /cases/1
  def destroy
    flash[:warning] = "Se ha destruído el anuncio: #{@case.title}"
    @case.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:announcement).permit(:title,:link,:image,:validity,:featured)
    end

end
