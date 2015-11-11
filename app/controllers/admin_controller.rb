class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :get_prefs


  def contact
    key = params[:key]
    value = params[:value]
    if request.patch?

      @prefs.values[key] = value
      if @prefs.update(prefs_params)
        flash[:success] = 'Se han guardado los cambios.'

        redirect_to contact_path
      else
        render :contact
      end
    end
  end

  def pref_del
    key = params[:key]
    value = params[:value]
    if request.delete?
      @prefs.values.delete key
      if @prefs.save
        flash[:success] = 'Se han borrado la información.'

        redirect_to contact_path
      else
        render :contact
      end
    end
  end


  def get_prefs
    if Preference.first.nil?
      p = Preference.new
      p.save
    end
    @prefs = Preference.first
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def prefs_params
      params.require(:preference).permit(:facebook,:twitter,:telephone,:telephone2,:email,:key,:value)
    end

end
