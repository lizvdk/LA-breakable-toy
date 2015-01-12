function drawIndexReportMap(){

  L.mapbox.accessToken = "pk.eyJ1IjoibGl6dmRrIiwiYSI6IlJodmpRdzQifQ.bUxjjqfXrx41XRFS7cXnIA";

  var map = L.mapbox.map("map", "lizvdk.knp8dn4m")
    .setView([42.36, -71.05], 8)
    .addControl(L.mapbox.geocoderControl('mapbox.places-v1', {
      autocomplete: true
    }));

  var featureLayer = L.mapbox.featureLayer()
    .loadURL('/reports.json')
    .addTo(map);

  var myLayer = L.mapbox.featureLayer().addTo(map);

  myLayer.on('layeradd', function(e) {
    var marker = e.layer,
    feature = marker.feature;

    // Create custom popup content
    var popupContent =
      '<a target="_blank" class="popup" href="' + feature.properties.url + '">' +
        '<img src="' + feature.properties.photo + '" />' +
        feature.properties.category +
      '</a>';

    // http://leafletjs.com/reference.html#popup
    marker.bindPopup(popupContent,{
      closeButton: false,
    });
  });

  // Add features to the map
  myLayer.loadURL('/reports.json').addTo(map);
}
