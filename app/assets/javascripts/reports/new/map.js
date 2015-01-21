function drawNewReportMap(){
  L.mapbox.accessToken = "pk.eyJ1IjoibGl6dmRrIiwiYSI6IlJodmpRdzQifQ.bUxjjqfXrx41XRFS7cXnIA";

  var geocoder = L.mapbox.geocoder('mapbox.places');
  var map = L.mapbox.map('map', 'lizvdk.ko5f732m', { zoomControl: false })
    .setView([42.3603, -71.0580], 20);
  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);
  var marker = L.marker(new L.LatLng(42.3603, -71.0580), {
    icon: L.mapbox.marker.icon({'marker-color': 'C14B7A', 'marker-size' : 'large' }),
    draggable: true
  });
  marker.addTo(map);

  function onLocationFound(e) {
    marker.setLatLng(e.latlng).update();
    marker.on('dragend', function (e) {
      $('#report_latitude').val(marker.getLatLng().lat);
      $('#report_longitude').val(marker.getLatLng().lng);
    });

  }

  function onLocationError(e) {
    alert(e.message);
  }

  map.on('locationfound', onLocationFound);
  map.on('locationerror', onLocationError);
  map.locate({setView: true, maxZoom: 16});

  $(function() {

    var $searchBox = $('.leaflet-control-mapbox-geocoder-form').children().first();
    var $formAddress = $('#report_address');

    $formAddress.focusout( function(e) {
      var address = $formAddress.val();
      geocoder.query(address, populateLatLong);
    });
  });

  function populateLatLong(err, data) {
    var lat = data.latlng[0];
    var lng = data.latlng[1];
    $('#report_latitude').val(lat);
    $('#report_longitude').val(lng);

    marker.setLatLng(data.latlng).update();

    map.panTo(data.latlng);
  }

}
