class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  layout 'admin'


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


  def save_batches_to_case(c)
    case_photos_batches = params[:batches]
    if case_photos_batches
      case_photos_batches.each_pair do |key,batch|
        batch['photos'].each_with_index do |photo,i|
          delete = batch['deleting']["#{i}"]
          order = batch['ordering']["#{i}"]
          year = batch['year']["#{i}"]
          month = batch['month']["#{i}"]
          weight = batch['weight']["#{i}"]

          if delete != "1"
            new_photo = c.photos.new
            new_photo.order = order
            new_photo.year = year
            new_photo.month = month
            new_photo.weight = weight
            new_photo.photo_file = photo
          end
        end
      end
    end
  end
  # POST /cases
  def create
    @case = Case.new(case_params)

    save_batches_to_case(@case)

    if @case.save
      flash[:success] = 'Se han guardado los cambios.'
      redirect_to cases_path
    else
      render :new
    end
  end

  # PATCH/PUT /cases/1
  def update

    save_batches_to_case(@case)

    if @case.update(case_params)
      flash[:success] = 'Se han guardado los cambios.'
      redirect_to cases_path
    else
      render :edit
    end
  end

  # DELETE /cases/1
  def destroy
    flash[:warning] = "Se han destruído el caso: #{@case.title}"
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:case).permit(:title, :description, :eleapsed_time, :weight_before, :weight_after, :waist_after, :waist_before, :product_used, photos_attributes: [:id,:photo_file,:month,:year,:weight,:order,:_destroy])
    end
    
end
