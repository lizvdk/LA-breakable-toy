function drawIndexReportMap(){

  var infowindow = new google.maps.InfoWindow();
  function gotoFeature(featureNum) {
    var feature = map.data.getFeatureById(features[featureNum].getId());
    if (!!feature) google.maps.event.trigger(feature, 'changeto', {feature: feature});
    else alert('feature not found!');
  }

  function initialize() {
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4,
      center: {lat: 42, lng:-71}
    });
    google.maps.event.addListener(map,'click',function() {
      infowindow.close();
    });
    var featureId = 0;

    map.data.addListener('click', function(event) {
      var reportCategory = event.feature.getProperty("category");
      var linkToReport = event.feature.getProperty("url");
      var reportPhoto = event.feature.getProperty("photo");
      infowindow.setContent("<a href=" + linkToReport + ">"+
                            "<img class='map-thumb' src='" +
                            reportPhoto + "'/>" +
                            "<br/>" +
                            reportCategory+"</div>");
      infowindow.setPosition(event.feature.getGeometry().get());
      infowindow.setOptions({pixelOffset: new google.maps.Size(0,-30)});
      infowindow.open(map);
    });
    map.data.loadGeoJson('/reports.json');

  }

  google.maps.event.addDomListener(window, 'load', initialize);

}
