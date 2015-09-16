angular.module('app.services', []).factory('Point', ->
  lastPointId = 0

  build: (label, coordinates) ->
    point =
      id: lastPointId++
      label: label
    angular.extend(point, coordinates)
    point
).factory('Geocoder', ['$q', ($q) ->
  geocoder = null
  initialize: (googleMapsGeocoder) ->
    geocoder = googleMapsGeocoder
  geocode: (location) ->
    defer = $q.defer()
    geocoder.geocode { location: location }, (results, status) ->
      if status is 'OK'
        defer.resolve(results[0].formatted_address)
      else
        defer.reject()
    defer.promise
])