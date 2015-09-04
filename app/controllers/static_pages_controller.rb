class StaticPagesController < ApplicationController
  def landing
    @case = Case.first
    Case.all.each do |c|
      if c.featured
        @case = c
      end 
    end
  end

  def casos
    @cases = Case.all
  end

  def contacto
    if Preference.first.nil?
      p = Preference.new
      p.save
    end
    @prefs = Preference.first
    @contact_model = ContactModel.new

  end

  def contact_send_mail
    begin
      @contact_form = ContactForm.new(params[:contact_form])
      @contact_form.request = request
      if @contact_form.deliver
        flash.now[:notice] = 'Thank you for your message!'
      else
        render :new
      end
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end


  def distribuidores
    @contact_model = ContactModel.new
  end

  def comprar
    @dealers = Dealer.all
  end

  private
      def distance loc1, loc2
        rad_per_deg = Math::PI/180  # PI / 180
        rkm = 6371                  # Earth radius in kilometers
        rm = rkm * 1000             # Radius in meters

        dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
        dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

        lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
        lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

        a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

        rm * c # Delta in meters
      end
end
