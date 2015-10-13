function drawIndexReportMap(){

  L.mapbox.accessToken = "pk.eyJ1IjoibGl6dmRrIiwiYSI6IlJodmpRdzQifQ.bUxjjqfXrx41XRFS7cXnIA";

  var map = L.mapbox.map("map", "lizvdk.knp8dn4m", { zoomControl: false })
  .setView([42.36, -71.05], 15)
  .addControl(L.mapbox.geocoderControl('mapbox.places-v1', {
    autocomplete: true,
    position: 'bottomright'
  }));
  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);

  var featureLayer = L.mapbox.featureLayer().addTo(map);

  featureLayer.on('layeradd', function (e) {
    featureLayer.eachLayer(function(layer) {
      var marker = e.layer,
      feature = marker.feature;
      marker.setIcon(L.divIcon(feature.properties.icon));
    });
  });

  featureLayer.loadURL('/reports.json');
  var markerList = document.getElementById('marker-list');
  var filters = document.getElementById('filters');


  map.featureLayer.on('ready', function(e) {
    featureLayer.eachLayer(function(layer) {
      var item = markerList.appendChild(document.createElement('li'));
      liContent =
                  "<div class='row'>" +
                    "<div class='small-2 columns'>" +
                      "<div class='" + layer.toGeoJSON().properties.icon.className + "'>" +
                          layer.toGeoJSON().properties.icon.html +
                      "</div>" +
                    "</div>" +
                    "<div class='small-10 columns'>" +
                      "<div><strong>" +
                        layer.toGeoJSON().properties.category +
                      "</div></strong>" +
                      "<div class>" +
                        "reported " +
                        layer.toGeoJSON().properties.created_at +
                      "</div>" +
                    "</div>" +
                  "</div>";

      item.innerHTML = liContent;
      item.onclick = function() {
        map.setView(layer.getLatLng(), 19);
        layer.openPopup();
      };
      var content =
                    '<a target="_blank" class="popup" href="' +
                      layer.feature.properties.url + '">' +
                      '<img class="th radius" src="' +
                        layer.feature.properties.photo +
                      '" />' +
                      layer.feature.properties.category +
                      '</a>';
      layer.bindPopup(content, { minWidth: 300 });
    });
  });
}
