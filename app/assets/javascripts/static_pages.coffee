# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'ready', ->
  setCookie = (name, value, days) ->
    if days
      date = new Date()
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000))
      expires = "; expires=" + date.toGMTString()
    else
      expires = ""
    document.cookie = name + "=" + value + expires + "; path=/"
  getCookie = (name) ->
    nameEQ = name + "="
    ca = document.cookie.split(";")
    i = 0

    while i < ca.length
      c = ca[i]
      c = c.substring(1, c.length)  while c.charAt(0) is " "
      return c.substring(nameEQ.length, c.length)  if c.indexOf(nameEQ) is 0
      i++
    null
  deleteCookie = (name) ->
    setCookie name, "", -1
  if getCookie 'anuncio'
    $('.anuncio').hide()
  $('.anuncio .close').on 'click', ->
    setCookie 'anuncio', 'batukeira', 1
    $('.anuncio').hide()
  $(window).on 'scroll', ->
    scroll_top = $(window).scrollTop();
    unless scroll_top > $('.nav-bar').height() || $('.nav-bar').hasClass('fixed')
      $('.nav-bar').removeClass 'scrolled'
    else
      $('.nav-bar').addClass 'scrolled'

  $('.menu-button').on 'click', ->
    r = '.nav-bar'
    unless $(r).hasClass 'exploded'
      $(r).addClass 'exploded'
    else
      $(r).removeClass 'exploded'

  $('.pregunta').on 'click', ->
    r = $(@).find('.respuesta')
    unless r.hasClass 'exploded'
      $(r).addClass 'exploded'
    else
      $(r).removeClass 'exploded'


  $("#contact-form button").on 'click', ->
    $(@).html 'Enviando...'

  $("#contact-form").on("ajax:success", (e, data, status, xhr) ->
    $(@).html data
    $(@).find('button').html 'Intentar de nuevo'
  ).on "ajax:error", (e, xhr, status, error) ->
    $(@).find('button').html 'Intentar de nuevo'
    alert "Hubo un error al enviar el correo, intente de nuevo más tarde."

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
