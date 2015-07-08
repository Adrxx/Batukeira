$(document).on 'page:change', ->

  dismissNotification = (notification) ->
    $(notification).css "opacity", "0.0"
    m = $(notification).css("margin-bottom").replace(/[^-\d\.]/g, '')
    $(notification).css "margin-bottom", "#{m-50}px"
    $(notification).nextAll('.c4-flash').each (i) ->
      m = $(@).css("margin-bottom").replace(/[^-\d\.]/g, '')
      $(@).css "margin-bottom", "#{m-50}px"
  
  $('.c4-flash').on "touchend click", ->
    dismissNotification(@)

  dismissAllNotifications = () ->
    #console.log "tada"
    $('.c4-flash').each ->
      dismissNotification(@)

  setTimeout(dismissAllNotifications, 3500)
    
  $(window).on 'scroll', ->
    scroll_top = $(window).scrollTop();
    if scroll_top > $('nav.c4').height()/2
      $('nav.c4').removeClass 'nav-opaque'
    else
      $('nav.c4').addClass 'nav-opaque'