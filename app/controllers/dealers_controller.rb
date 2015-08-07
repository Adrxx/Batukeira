class DealersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dealer, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  # GET /dealers
  # GET /dealers.json
  def index
    @dealers = Dealer.all
  end

  # GET /dealers/new
  def new
    @dealer = Dealer.new
  end

  # GET /dealers/1/edit
  def edit
  end

  # POST /dealers
  # POST /dealers.json
  def create
    @dealer = Dealer.new(dealer_params)
    respond_to do |format|
      if @dealer.save
        flash[:success] = 'Se han guardado los cambios.'
        format.html { redirect_to dealers_url }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /dealers/1
  # PATCH/PUT /dealers/1.json
  def update
    respond_to do |format|
      if @dealer.update(dealer_params)
        flash[:success] = 'Se han guardado los cambios.'
        format.html { redirect_to dealers_url }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /dealers/1
  # DELETE /dealers/1.json
  def destroy
    @dealer.destroy
    respond_to do |format|
      flash[:warning] = "Se ha destruído el distribuidor: #{@dealer.name}"
      format.html { redirect_to dealers_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dealer
      @dealer = Dealer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dealer_params
      params.require(:dealer).permit(:name, :telephone, :telephone2, :email, :address, :latitude, :longitude, :hidden_telephone, :hidden_telephone2, :hidden_email, :hidden_address)
    end
end
