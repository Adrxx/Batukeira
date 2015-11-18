$(document).on 'ready', ->
  addressPicker = new AddressPicker
    map:
      id: '#map-location-picker'
    autocompleteService:
      types: ['address']
      componentRestrictions:
        country: 'MX'
    reverseGeocoding: true


  $('#dealer_address').typeahead null,
    displayKey: 'description'
    source: addressPicker.ttAdapter()

  # Bind some event to update map on autocomplete selection
  $('#dealer_address').bind('typeahead:selected', addressPicker.updateMap)

  $('#dealer_address').bind('typeahead:cursorchanged', addressPicker.updateMap)

  $(addressPicker).on 'addresspicker:selected', (event, result) ->
    $('#dealer_address').val(result.address())
    $('#dealer_latitude').val(result.lat())
    $('#dealer_longitude').val(result.lng())

  setMapCoordinates = (lat,lng,zoom,map) ->
    marker = new google.maps.Marker
      #draggable:true
      position:
        lat: lat
        lng: lng
      map: map

    map.setCenter
      lat: lat
      lng: lng

    map.setZoom zoom

    
  lat = parseFloat $('#dealer_latitude').val()
  lng = parseFloat $('#dealer_longitude').val()
  #console.log lat
  #console.log lng

  setMapCoordinates(lat,lng,16,addressPicker.map)
