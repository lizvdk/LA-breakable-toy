function drawIndexReportMap(){

  L.mapbox.accessToken = "pk.eyJ1IjoibGl6dmRrIiwiYSI6IlJodmpRdzQifQ.bUxjjqfXrx41XRFS7cXnIA";

  var map = L.mapbox.map("map", "lizvdk.knp8dn4m")
  .setView([42.36, -71.05], 9)
  .addControl(L.mapbox.geocoderControl('mapbox.places-v1', {
    autocomplete: true
  }));


  var featureLayer = L.mapbox.featureLayer()
    .loadURL('/reports.json')
    .addTo(map);

  // Ahead of time, select the elements we'll need -
  // the narrative container and the individual sections
  var narrative = $('#all-reports').get(0);
  var sections = $('#all-reports').find('section');
  var currentId = '';

  setId('cover');

  function setId(newId) {
    // If the ID hasn't actually changed, don't do anything
    if (newId === currentId) return;
    // Otherwise, iterate through layers, setting the current
    // marker to a different color and zooming to it.
    featureLayer.eachLayer(function(layer) {
      if (layer.feature.properties.id === newId) {
        map.setView(layer.getLatLng(), layer.feature.properties.zoom || 14);
        layer.setIcon(L.mapbox.marker.icon({
          'marker-size': 'large',
          'marker-color': '#000',
          'marker-symbol': layer.feature.properties['marker-symbol']
        }));
      } else {
        layer.setIcon(L.mapbox.marker.icon({
          'marker-size': 'small',
          'marker-color': layer.feature.properties['marker-color'],
          'marker-symbol': layer.feature.properties['marker-symbol']
        }));
      }
    });
    // highlight the current section
    for (var i = 0; i < sections.length; i++) {
      sections[i].className = sections[i].id === newId ? 'active' : '';
    }
    // And then set the new id as the current one,
    // so that we know to do nothing at the beginning
    // of this function if it hasn't changed between calls
    currentId = newId;
  }

  // If you were to do this for real, you would want to use
  // something like underscore's _.debounce function to prevent this
  // call from firing constantly.
  narrative.onscroll = function(e) {
    var narrativeHeight = narrative.offsetHeight;
    var newId = currentId;
    // Find the section that's currently scrolled-to.
    // We iterate backwards here so that we find the topmost one.
    for (var i = sections.length - 1; i >= 0; i--) {
      var rect = sections[i].getBoundingClientRect();
      if (rect.top >= 0 && rect.top <= narrativeHeight) {
        newId = sections[i].id;
      }
    }
    setId(newId);
  };

}
