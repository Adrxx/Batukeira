(($, window) ->
  # Define the plugin class
  class photoManager

    defaults:
      paramA: 'foo'
      paramB: 'bar'

    constructor: (el, options) ->
      @options = $.extend({}, @defaults, options)
      @$el = $(el)
 
    # Additional plugin methods go here
    myMethod: (echo) ->
      @$el.html(@options.paramA + ': ' + echo)
 
  # Define the plugin
  $.fn.extend photoManager: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('photoManager')
 
      if !data
        $this.data 'photoManager', (data = new photoManager(this, option))
      if typeof option == 'string'
        data[option].apply(data, args)
 
) window.jQuery, window