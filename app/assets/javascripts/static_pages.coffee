# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  $(window).on 'scroll', ->
    scroll_top = $(window).scrollTop();
    unless scroll_top > $('.nav-bar').height() || $('.nav-bar').hasClass('fixed')
      $('.nav-bar').removeClass 'scrolled'
    else
      $('.nav-bar').addClass 'scrolled'

  $('.menu-button').on 'click', ->
    r = $('.nav-bar')
    unless r.hasClass 'exploded'
      $(r).addClass 'exploded'
    else
      $(r).removeClass 'exploded'

  $('.pregunta').on 'click', ->
    r = $(this).find('.respuesta')
    unless r.hasClass 'exploded'
      $(r).addClass 'exploded'
    else
      $(r).removeClass 'exploded'

  got_location = (position) ->
    $.ajax
      type: 'POST'
      async: true
      url: "/locate_me"
      data: {lat: position.coords.latitude, lng: position.coords.longitude }
      success: (data, textStatus, jqXHR) ->
        $('.todos-los-distribuidores .titulo').html 'Estos son los distribuidores más cercanos a ti.'
        $('.distribuidores-listado').html data
        #$('.distribuidores-listado').show()

      error: (jqXHR, textStatus, errorThrown) ->
        $('.todos-los-distribuidores .titulo').html 'No pudimos localizarte... Esta es la lista entera de distribuidores.'
        #$('.distribuidores-listado').show()



  element =  document.getElementById('geolocation');
  if (typeof(element) != 'undefined' && element != null)
    #console.log('asds')
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(got_location)


#$(document).on('ready page:load', console.log("ASHKDJHASKJHDKASJH")) IT DOESNT FUCKING WORK
