(function(){$(document).on("page:change",function(){var e,a,d,t;return e=new AddressPicker({map:{id:"#map-location-picker"},autocompleteService:{types:["address"],componentRestrictions:{country:"MX"}},reverseGeocoding:!0}),$("#dealer_address").typeahead(null,{displayKey:"description",source:e.ttAdapter()}),$("#dealer_address").bind("typeahead:selected",e.updateMap),$("#dealer_address").bind("typeahead:cursorchanged",e.updateMap),$(e).on("addresspicker:selected",function(e,a){return $("#dealer_address").val(a.address()),$("#dealer_latitude").val(a.lat()),$("#dealer_longitude").val(a.lng())}),t=function(e,a,d,t){var r;return r=new google.maps.Marker({position:{lat:e,lng:a},map:t}),t.setCenter({lat:e,lng:a}),t.setZoom(d)},a=parseFloat($("#dealer_latitude").val()),d=parseFloat($("#dealer_longitude").val()),t(a,d,16,e.map)})}).call(this);