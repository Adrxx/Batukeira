$(document).on 'page:change', ->

  orderIndexes = ->
    $('.mnt-photo-manager').children('.container').each ->
        $(this).children('.ordering').val($(this).index())

  $('#batch-input').on "dragenter", ->
    $('.mtn-photo-manager').css "background-color", "tomato"
    $(this).css "background-color", "red"

  $('#batch-input').on "change", ->
    input_field = this
    if this.files.length > 0
      batch_index = $('.mnt-pm-file-input').length-1;
      file_index = 0
      for f in this.files
        reader = new FileReader()
        reader.onload = (e) ->
          $('.mnt-photo-manager').prepend("<div class='container normal'>
            <div class='photo' style='background-image: url(#{e.target.result})' ><div class='delete'></div></div>
            <input type='hidden'name='batches[#{batch_index}][ordering][#{file_index}]' class='ordering'>
            <input type='hidden' name='batches[#{batch_index}][deleting][#{file_index}]' class='destroyer' value='0'>
          </div>")
          file_index++
          orderIndexes()
        reader.readAsDataURL(f)
      clone = $(input_field).clone(true)
      $(input_field).attr "id" , ""
      $(input_field).attr "name" , "batches[#{batch_index}][photos][]"
      $(input_field).hide()
      $(clone).insertBefore(input_field)

  $('.mnt-photo-manager').on "click", '.delete', ->
    $(this).parent().parent().fadeOut()
    $(this).parent().siblings('.destroyer').val(1)

  $('.mnt-photo-manager').on "mousedown", ".photo" , ->
    #Save dragging item for other scope use...
    current = this
    #Save coordinates of dragging item in its coordinate system
    originX = event.pageX - $(this).offset().left
    originY = event.pageY - $(this).offset().top
    #Iterate over every non dragging element
    $('.mnt-photo-manager').children('.normal').each ->
      $(this).find('.photo').removeClass "top"
    $(this).addClass "top" #Bring to front
    $(this).removeClass("ordering").addClass "dragging"
    $(this).parent().removeClass("normal").addClass "placeholder"
    $(document).on "mousemove", ->
      x = event.pageX
      y = event.pageY
      $('.mnt-photo-manager').children('.normal').each ->
        #If dragging item is over non dragging item...
        if (x > $(this).offset().left && x < $(this).offset().left + $(this).width()) && (y > $(this).offset().top && y < $(this).offset().top + $(this).height())
          i = $(this).index()
          #Take array of draggable items and insert to-drop item at correct index
          arr = $('.mnt-photo-manager').children('.normal')
          arr.splice(i,0,current.parentNode)
          spacer = $('.spacer')[0]
          $(arr).insertBefore(spacer)
          return false
      #Position item
      $(current).offset {"top":event.pageY-originY,"left":event.pageX-originX}
    $(document).one "mouseup", ->
      orderIndexes()
      $(current).removeClass("dragging").addClass "ordering"
      $(current).parent().removeClass("placeholder").addClass "normal"
      $(current).css {"top":"0px","left":"0px"} #Restore to container position
      $(document).unbind "mousemove"


