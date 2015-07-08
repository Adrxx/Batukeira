$(document).on 'page:change', ->

  #Used to set the ordering atribute to each of each photo
  orderIndexes = ->
    $('.mnt-photo-manager').children('.mnt-pm-container').each ->
        $(this).children('.mnt-pm-p-order').val($(this).index())

  #Drop area 'You can drop now' message setup
  $('.mnt-pm-banner').on "dragenter", ->
    $(this).find('.mnt-pm-normal').hide()
    $(this).find('.mnt-pm-drop').show()

  #Restore drop area text
  $('.mnt-pm-banner').on "dragleave drop", ->
    $(this).find('.mnt-pm-drop').hide()
    $(this).find('.mnt-pm-normal').show()

  #Photo added handler
  $('#batch-input').on "change", ->
    input_field = this
    #Validate file format
    valid = true
    for f in this.files
      extension = f.name.substring(f.name.lastIndexOf(".")+1)
      unless /jpg|jpeg|png|gif/i.test(extension)
        alert "Solamente se pueden subir imágenes con formato jpg png o gif."
        valid = false
        break
    if this.files.length > 0 && valid
      batch_index = $('.mnt-pm-file-input').length-1;
      file_index = 0
      for f in this.files
        reader = new FileReader()
        reader.onload = (e) ->
          $('.mnt-photo-manager').prepend("<div class='mnt-pm-container mnt-pm-normal'>
            <div class='mnt-pm-photo' style='background-image: url(#{e.target.result})'></div>
            <input type='hidden'name='batches[#{batch_index}][ordering][#{file_index}]' class='mnt-pm-p-order'>
            <input type='hidden'name='batches[#{batch_index}][year][#{file_index}]' class='mnt-pm-p-year'>
            <input type='hidden'name='batches[#{batch_index}][month][#{file_index}]' class='mnt-pm-p-month'>
            <input type='hidden'name='batches[#{batch_index}][weight][#{file_index}]' class='mnt-pm-p-weigth'>
            <input type='hidden' name='batches[#{batch_index}][deleting][#{file_index}]' class='mnt-pm-p-destroyer' value='0'>
            <span class='mnt-pm-delete'></span>
            <span class='mnt-pm-comment'></span>
          </div>")
          file_index++
          orderIndexes()
        reader.readAsDataURL(f)
      clone = $(input_field).clone(true)
      $(input_field).attr "id" , ""
      $(input_field).attr "name" , "batches[#{batch_index}][photos][]"
      $(input_field).hide()
      $(clone).insertBefore(input_field)

  #Open edit photo pop up overlay read values from hidden input tags
  $('.mnt-photo-manager').on "click", '.mnt-pm-comment', ->
    $('.mnt-photo-manager').children('.mnt-pm-normal').each ->
      $(this).find('.mnt-pm-photo').removeClass "mnt-pm-top"
    $('.mnt-full-overlay').fadeIn()
    #Get values
    photo = $(this).siblings('.mnt-pm-photo').css "background-image"
    year = $(this).siblings('.mnt-pm-p-year').val()
    month = $(this).siblings('.mnt-pm-p-month').val()
    weight = $(this).siblings('.mnt-pm-p-weight').val()
    #Set values
    $('.mnt-pm-thumbnail').css "background-image", photo
    $('.mnt-pm-month-select').val(month)
    $('.mnt-pm-year-select').val(year)
    $('.mnt-pm-weight-select').val(weight)

    window.currentPhotoContainer = this.parentNode

  #Save photo detail editor data to photo
  $('.mnt-pm-save, .mnt-full-overlay').on "click", ->
    if event.target != this
      return
    month = $('.mnt-pm-month-select').val()
    year = $('.mnt-pm-year-select').val()
    weight = $('.mnt-pm-weight-select').val()

    year ?= '0000'
    month ?= '00'

    current = window.currentPhotoContainer
    if current
      $(current).find('.mnt-pm-p-weight').val(weight)
      $(current).find('.mnt-pm-p-month').val(month)
      $(current).find('.mnt-pm-p-year').val(year)

    $('.mnt-full-overlay').fadeOut()

  #Delete photo handler
  $('.mnt-photo-manager').on "click", '.mnt-pm-delete', ->
    $(this).parent().fadeOut()
    $(this).siblings('.mnt-pm-p-destroyer').val(1)

  #Drag n drop magic ;)
  $('.mnt-photo-manager').on "mousedown touchstart", ".mnt-pm-photo" , ->
    event.preventDefault()
    #Save dragging item for other scope use...
    current = this
    #Save coordinates of dragging item in its coordinate system
    originX = event.pageX - $(this).offset().left
    originY = event.pageY - $(this).offset().top
    #Iterate over every non dragging element
    $('.mnt-photo-manager').children('.mnt-pm-normal').each ->
      $(this).find('.mnt-pm-photo').removeClass "mnt-pm-top"
    $(this).addClass "mnt-pm-top" #Bring to front
    $(this).removeClass("mnt-pm-ordering").addClass "mnt-pm-dragging"
    $(this).parent().removeClass("mnt-pm-normal").addClass "mnt-pm-placeholder"
    $(document).on "mousemove touchmove", ->
      event.preventDefault()
      x = event.pageX
      y = event.pageY
      $('.mnt-photo-manager').children('.mnt-pm-normal').each ->
        #If dragging item is over non dragging item...
        if (x > $(this).offset().left && x < $(this).offset().left + $(this).width()) && (y > $(this).offset().top && y < $(this).offset().top + $(this).height())
          i = $(this).index()
          #Take array of draggable items and insert to-drop item at correct index
          arr = $('.mnt-photo-manager').children('.mnt-pm-normal')
          arr.splice(i,0,current.parentNode)
          spacer = $('.mnt-pm-spacer')[0]
          $(arr).insertBefore(spacer)
          return false
      #Position item
      $(current).offset {"top":event.pageY-originY,"left":event.pageX-originX}
    $(document).one "mouseup touchend", ->
      event.preventDefault()

      orderIndexes()
      $(current).removeClass("mnt-pm-dragging").addClass "mnt-pm-ordering"
      $(current).parent().removeClass("mnt-pm-placeholder").addClass "mnt-pm-normal"
      $(current).css {"top":"0px","left":"0px"}
      #Restore to container position
      $(document).unbind "mousemove touchmove"

  #Numeric input
  $('.mnt-pm-numeric-input').keydown (e) ->
    #Allow: backspace, delete, tab, escape, enter and .
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) != -1)
        return
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))
      e.preventDefault();
        

