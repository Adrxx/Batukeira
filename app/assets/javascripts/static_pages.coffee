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

