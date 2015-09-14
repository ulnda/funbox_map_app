angular.module('app.controllers', []).controller('HomeController', ['$scope',
  '$modal', ($scope, $modal) ->

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
    $scope.removePoint = (point) ->
      $modal.open
        templateUrl: 'templates/deleting_modal.html'
        controller: 'DeletingPointModalController'
        size: 'sm'
        resolve:
          points: ->
            $scope.points
          point: ->
            point
]).controller('DeletingPointModalController', ['$modalInstance', '$scope',
  'points', 'point', ($modalInstance, $scope, points, point) ->

    $scope.point = point

    $scope.ok = ->
      points.splice points.indexOf(point), 1
      $modalInstance.dismiss('ok')
    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
])