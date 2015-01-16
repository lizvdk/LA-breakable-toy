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

  map.featureLayer.on('ready', function(e) {
    featureLayer.eachLayer(function(layer) {
      var content = '<a target="_blank" class="popup" href="' +
      layer.feature.properties.url + '">' +
      '<img src="' + layer.feature.properties.photo + '" />' +
      layer.feature.properties.category +
      '</a>';
      layer.bindPopup(content);
    });
  });

}
