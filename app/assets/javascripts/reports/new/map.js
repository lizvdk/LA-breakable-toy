function drawNewReportMap(){
  L.mapbox.accessToken = "pk.eyJ1IjoibGl6dmRrIiwiYSI6IlJodmpRdzQifQ.bUxjjqfXrx41XRFS7cXnIA";

  var map = L.mapbox.map('map', 'lizvdk.ko5f732m', { zoomControl: false });
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
  var $address = $formAddress.val();
  var $geolocate = $('#geolocate');
  map.fitBounds([
    [42.346397049733966, -71.1029577255249],
    [42.369451896762385, -71.04429244995117]
    ]);

  if (!navigator.geolocation) {
    $geolocate.val('Geolocation is not available');
  } else {
    $geolocate.on('click', function (e) {
      e.preventDefault();
      e.stopPropagation();
      map.locate();
    });
  }

  map.on('locationfound', function(e) {
    map.fitBounds(e.bounds, {paddingTopLeft: [250, 0]});
    marker.setLatLng(e.latlng).update();
    ondragend();
  });

  map.on('locationerror', function() {
    alert('Not found, enter your address');
  });

  function ondragend() {
    var m = marker.getLatLng();
    $formLat.val(marker.getLatLng().lat);
    $formLng.val(marker.getLatLng().lng);

    geocoder.reverseQuery(m, populateAddress);
  }

  function geocodeAddress () {
    $formAddress.change(function(e) {
      var address = $formAddress.val();
      geocoder.query(address, moveMarkerPopulateLatLong);
    });
  }

  function moveMarkerPopulateLatLong(err, data) {
    var lat = data.latlng[0];
    var lng = data.latlng[1];
    $formLat.val(lat);
    $formLng.val(lng);

    marker.setLatLng(data.latlng).update();
    map.panTo(data.latlng);
  }

  function populateAddress(err, data) {
    $formAddress.val(data.features[0]["place_name"]);
  }

  marker.addTo(map);
  marker.on('dragend', ondragend);
  ondragend();
  geocodeAddress();
}
