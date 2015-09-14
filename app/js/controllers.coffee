angular.module('app.controllers', []).controller('HomeController', ['$scope', 
  ($scope) ->

    $scope.markers = []
    $scope.map =
      center:
        latitude: 45
        longitude: -73
      zoom: 16
      events: {}
])