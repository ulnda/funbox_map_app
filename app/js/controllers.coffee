angular.module('app.controllers', []).controller('HomeController', ['$scope', 
  ($scope) ->

    $scope.markers = []
    $scope.map =
      center:
        latitude: 45
        longitude: -73
      zoom: 16
      events: {}

    $scope.points = []
    for i in [1..5]
      $scope.points.push {label: "Точка \##{ i }"}
])