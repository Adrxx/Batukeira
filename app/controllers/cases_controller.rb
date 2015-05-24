class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  # GET /cases
  def index
    @cases = Case.all
  end

  # GET /cases/1
  def show
  end

  # GET /cases/new
  def new
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
  end

  # POST /cases
  def create
    @case = Case.new(case_params)

    #Save photos...
    photos_params.each do |p|
      new_photo = @case.photos.new
      new_photo.photo_file = p
    end

    respond_to do |format|
      if @case.save
        format.html { redirect_to @case, notice: 'Case was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /cases/1
  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to @case, notice: 'Case was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /cases/1
  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:case).permit(:title, :description, :eleapsed_time, :weight_loss, :product_used, photos_attributes: [:id,:photo_file,:order,:_destroy])
    end

    def photos_params
      params.require(:case)[:photos]
    end
    
end
