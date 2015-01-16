function drawNewReportMap(){
  L.mapbox.accessToken = "pk.eyJ1IjoibGl6dmRrIiwiYSI6IlJodmpRdzQifQ.bUxjjqfXrx41XRFS7cXnIA";
  var geocoder = L.mapbox.geocoder('mapbox.places');

  var map = L.mapbox.map('map', 'lizvdk.ko5f732m')
  .addControl(L.mapbox.geocoderControl('mapbox.places-v1', {
    keepOpen: true,
    autocomplete: true
  }));

  function onLocationFound(e) {
    var marker = L.marker(e.latlng, {
      icon: L.mapbox.marker.icon({ 'marker-color': '#f86767' }),
      draggable: true
    }).addTo(map);

    marker.on('dragend', function (e) {
      document.getElementById('report_latitude').value = marker.getLatLng().lat;
      document.getElementById('report_longitude').value = marker.getLatLng().lng;
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
      // var searchContent = $searchBox.val();
      // $formAddress.val(searchContent);
      var address = $formAddress.val();
      geocoder.query(address, populateLatLong);
    });
  });

  function populateLatLong(err, data) {
    var lat = data.latlng[0];
    var long = data.latlng[1];
    $('#report_latitude').val(lat);
    $('#report_longitude').val(long);

    L.marker(data.latlng, {
      icon: L.mapbox.marker.icon({ 'marker-color': '#f86767' }),
      draggable: true
    }).addTo(map);

    map.panTo(data.latlng);
  }

}
