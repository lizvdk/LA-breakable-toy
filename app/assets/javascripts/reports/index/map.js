function drawIndexReportMap(){

  var infowindow = new google.maps.InfoWindow();
  function gotoFeature(featureNum) {
    var feature = map.data.getFeatureById(features[featureNum].getId());
    if (!!feature) google.maps.event.trigger(feature, 'changeto', {feature: feature});
    else alert('feature not found!');
  }

  function initialize() {
    // Create a simple map.
    features=[];
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4,
      center: {lat: 42, lng:-71}
    });
    google.maps.event.addListener(map,'click',function() {
      infowindow.close();
    });
    map.data.setStyle({fillOpacity:.8});
    // Load a GeoJSON from the same server as our demo.
    var featureId = 0;
    google.maps.event.addListener(map.data,'addfeature',function(e){
      if(e.feature.getGeometry().getType()==='Polygon'){
        features.push(e.feature);
        var bounds=new google.maps.LatLngBounds();

        e.feature.getGeometry().getArray().forEach(function(path){

          path.getArray().forEach(function(latLng){bounds.extend(latLng);})

        });
        e.feature.setProperty('bounds',bounds);
        e.feature.setProperty('featureNum',features.length-1);



      }
    });
    // When the user clicks, open an infowindow
    map.data.addListener('click', function(event) {
      var reportCategory = event.feature.getProperty("category");
      var linkToReport = event.feature.getProperty("url");
      infowindow.setContent("<a href=" + linkToReport + ">"+reportCategory+"</div>");
      infowindow.setPosition(event.feature.getGeometry().get());
      infowindow.setOptions({pixelOffset: new google.maps.Size(0,-30)});
      infowindow.open(map);
    });
    map.data.loadGeoJson('/reports.json');

  }

  google.maps.event.addDomListener(window, 'load', initialize);

}
