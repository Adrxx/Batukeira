$(document).on 'page:change', ->
  $('.mnt-photo-uploader .delete').on "click", ->

  $('.mnt-photo-uploader .photo').on "mousedown", ->
    #Save dragging item for other scope use...
    current = this
    #Save coordinates of dragging item in its coordinate system
    originX = event.pageX - $(this).offset().left
    originY = event.pageY - $(this).offset().top
    #Iterate over every non dragging element
    $('.mnt-photo-uploader').children('.normal').each ->
      $(this).find('.photo').removeClass "top"
    $(this).addClass "top" #Bring to front
    $(this).removeClass("ordering").addClass "dragging"
    $(this).parent().removeClass("normal").addClass "placeholder"
    $(document).on "mousemove", ->
      x = event.pageX
      y = event.pageY
      $('.mnt-photo-uploader').children('.normal').each ->
        #If dragging item is over non dragging item...
        if (x > $(this).offset().left && x < $(this).offset().left + $(this).width()) && (y > $(this).offset().top && y < $(this).offset().top + $(this).height())
          i = $(this).index()
          #Take array of draggable items and insert to-drop item at correct index
          arr = $('.mnt-photo-uploader').children('.normal')
          arr.splice(i,0,current.parentNode)
          spacer = $('.spacer')[0]
          $(arr).insertBefore(spacer)
          return false
      #Position item
      $(current).offset {"top":event.pageY-originY,"left":event.pageX-originX}
    $(document).one "mouseup", ->
      $('.mnt-photo-uploader').children('.container').each ->
        $(this).children('.ordering').val($(this).index())
      $(current).removeClass("dragging").addClass "ordering"
      $(current).parent().removeClass("placeholder").addClass "normal"
      $(current).css {"top":"0px","left":"0px"} #Restore to container position
      $(document).unbind "mousemove"


