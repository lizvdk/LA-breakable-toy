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

  var markerList = document.getElementById('marker-list');
  var filters = document.getElementById('filters');


  map.featureLayer.on('ready', function(e) {
    var typesObj = {}, types = [];
    var features = map.featureLayer.getGeoJSON().features;
    for (var i = 0; i < features.length; i++) {
      typesObj[features[i].properties['marker-symbol']] = true;
    }
    for (var k in typesObj) types.push(k);

    var checkboxes = [];
    for (var i = 0; i < types.length; i++) {
      // Create an an input checkbox and label inside.
      var item = filters.appendChild(document.createElement('div'));
      var checkbox = item.appendChild(document.createElement('input'));
      var label = item.appendChild(document.createElement('label'));
      checkbox.type = 'checkbox';
      checkbox.id = types[i];
      checkbox.checked = true;
      // create a label to the right of the checkbox with explanatory text
      label.innerHTML = types[i];
      label.setAttribute('for', types[i]);
      // Whenever a person clicks on this checkbox, call the update().
      checkbox.addEventListener('change', update);
      checkboxes.push(checkbox);
    }

    featureLayer.eachLayer(function(layer) {
      var item = markerList.appendChild(document.createElement('li'));
      item.innerHTML = layer.toGeoJSON().properties.category;
      item.onclick = function() {
        map.setView(layer.getLatLng(), 14);
        layer.openPopup();
      };
      var content = '<a target="_blank" class="popup" href="' +
      layer.feature.properties.url + '">' +
      '<img src="' + layer.feature.properties.photo + '" />' +
      layer.feature.properties.category +
      '</a>';
      layer.bindPopup(content);
    });
  });

  function update() {
    var enabled = {};
    // Run through each checkbox and record whether it is checked. If it is,
    // add it to the object of types to display, otherwise do not.
    for (var i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i].checked) enabled[checkboxes[i].id] = true;
    }
    map.featureLayer.setFilter(function(feature) {
      // If this symbol is in the list, return true. if not, return false.
      // The 'in' operator in javascript does exactly that: given a string
      // or number, it says if that is in a object.
      // 2 in { 2: true } // true
      // 2 in { } // false
      return (feature.properties['marker-symbol'] in enabled);
    });
  }

}
