(function() {
  $(document).on('page:change', function() {
    var addressPicker, lat, lng, setMapCoordinates;
    addressPicker = new AddressPicker({
      map: {
        id: '#map-location-picker'
      },
      autocompleteService: {
        types: ['address'],
        componentRestrictions: {
          country: 'MX'
        }
      },
      reverseGeocoding: true
    });
    $('#dealer_address').typeahead(null, {
      displayKey: 'description',
      source: addressPicker.ttAdapter()
    });
    $('#dealer_address').bind('typeahead:selected', addressPicker.updateMap);
    $('#dealer_address').bind('typeahead:cursorchanged', addressPicker.updateMap);
    $(addressPicker).on('addresspicker:selected', function(event, result) {
      $('#dealer_address').val(result.address());
      $('#dealer_latitude').val(result.lat());
      return $('#dealer_longitude').val(result.lng());
    });
    setMapCoordinates = function(lat, lng, zoom, map) {
      var marker;
      marker = new google.maps.Marker({
        position: {
          lat: lat,
          lng: lng
        },
        map: map
      });
      map.setCenter({
        lat: lat,
        lng: lng
      });
      return map.setZoom(zoom);
    };
    lat = parseFloat($('#dealer_latitude').val());
    lng = parseFloat($('#dealer_longitude').val());
    return setMapCoordinates(lat, lng, 16, addressPicker.map);
  });

}).call(this);
