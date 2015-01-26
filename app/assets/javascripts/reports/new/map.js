function drawNewReportMap(){
  L.mapbox.accessToken = "pk.eyJ1IjoibGl6dmRrIiwiYSI6IlJodmpRdzQifQ.bUxjjqfXrx41XRFS7cXnIA";

  var map = L.mapbox.map('map', 'lizvdk.ko5f732m', { zoomControl: false })
  .setView([42.3603, -71.0580], 20);
  var geocoder = L.mapbox.geocoder('mapbox.places');
  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);
  var marker = L.marker(new L.LatLng(42.3603, -71.0580), {
    icon: L.mapbox.marker.icon({'marker-color': 'C14B7A', 'marker-size' : 'large' }),
    draggable: true
  });
  var $searchBox = $('.leaflet-control-mapbox-geocoder-form').children().first();
  var $formAddress = $('#report_address');
  var $formLat = $('#report_latitude');
  var $formLng = $('#report_longitude');

  function ondragend() {
    var m = marker.getLatLng();
    $formLat.val(marker.getLatLng().lat);
    $formLng.val(marker.getLatLng().lng);
  }

  function geocodeAddress () {
    $formAddress.change(function(e) {
      var address = $formAddress.val();
      geocoder.query(address, populateLatLong);
    });
  }

  function populateLatLong(err, data) {
    var lat = data.latlng[0];
    var lng = data.latlng[1];
    $formLat.val(lat);
    $formLng.val(lng);

    marker.setLatLng(data.latlng).update();
    map.panTo(data.latlng);
  }

  marker.addTo(map);
  marker.on('dragend', ondragend);
  ondragend();
  geocodeAddress();
}
