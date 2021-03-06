class StaticPagesController < ApplicationController

  def initialize
    super
    if Preference.first.nil?
      p = Preference.new
      p.save
    end
  end

  def landing
    @case = Case.first
    Case.all.each do |c|
      if c.featured
        @case = c
      end
    end
  end

  def locate_me

    lat = params[:lat]
    lng = params[:lng]

    @ajax_dealers = Dealer.all.sort_by do |d|
      diss = haversine_distance( lat.to_d, lng.to_d, d.latitude, d.longitude)
      puts diss[:km]
      d.km = diss[:km]
      diss[:km]
    end

    render  'lista_distribuidores', :layout => false

  end

  def casos
    @cases = Case.all
  end

  def contacto
    @prefs = Preference.first
    @contact = Contact.new
  end

  def enviar_contacto
    @prefs = Preference.first
    @contact = Contact.new(params[:contact])
    @contact.request = request

    if @contact.deliver
      render partial: 'distribuidores_contacto_success'
    else
      render partial: 'contacto_contacto'
    end
  end

  def distribuidores
    @dealer_contact = DealerContact.new
  end

  def enviar_distribuidor
    @dealer_contact = DealerContact.new(params[:dealer_contact])
    @dealer_contact.request = request

    if @dealer_contact.deliver
      render partial: 'distribuidores_contacto_success'
    else
      render partial: 'distribuidores_contacto'
    end

  end

  def comprar
    @dealers = Dealer.all
  end


  private
    def haversine_distance( lat1, lon1, lat2, lon2 )

    rad_per_deg = 0.017453293
    rmiles  = 3956           # radius of the great circle in miles
    rkm     = 6371           # radius in kilometers, some algorithms use 6367
    rfeet   = rmiles * 5282  # radius in feet
    rmeters = rkm * 1000

    dlon = lon2 - lon1
    dlat = lat2 - lat1

    dlon_rad = dlon * rad_per_deg
    dlat_rad = dlat * rad_per_deg

    lat1_rad = lat1 * rad_per_deg
    lon1_rad = lon1 * rad_per_deg

    lat2_rad = lat2 * rad_per_deg
    lon2_rad = lon2 * rad_per_deg

    a = (Math.sin(dlat_rad/2))**2 + Math.cos(lat1_rad) *
         Math.cos(lat2_rad) * (Math.sin(dlon_rad/2))**2
    c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))

    dMi     = nil #rmiles * c      # delta between the two points in miles
    dKm     = rkm * c         # delta in kilometers
    dFeet   = nil #rfeet * c       # delta in feet
    dMeters = nil #rmeters * c     # delta in meters

    { :mi => dMi, :km => dKm, :ft => dFeet, :m => dMeters }
  end

end
