angular.module('app.controllers', []).controller('HomeController', ['$scope', 
  ($scope) ->

    $scope.markers = []
    $scope.map =
      center:
        latitude: 45
        longitude: -73
      zoom: 16
      events: {}

    $scope.point = {}

    $scope.points = []
    for i in [1..5]
      $scope.points.push {label: "Точка \##{ i }"}

    $scope.addNewPoint = ->
      if $scope.point.label
        $scope.points.push angular.copy($scope.point) 
        $scope.point = {}
])