angular.module('app.services', []).factory('Point', ->
  lastPointId = 0

  build: (label, coordinates) ->
    point =
      id: lastPointId++
      label: label
    angular.extend(point, coordinates)
    point
)