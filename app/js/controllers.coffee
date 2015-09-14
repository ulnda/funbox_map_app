angular.module('app.controllers', []).controller('HomeController', ['$scope',
  '$modal', ($scope, $modal) ->

    lastPointId = 0

    $scope.points = []
    $scope.point = {}

    $scope.options =
      map:
        center:
          latitude: 45
          longitude: -73
        zoom: 16
      point:
        icon: 'img/marker.png'
        draggable: true
      route: 
        path: $scope.points
        stroke:
          color: '#FF0066'
          weight: 3
        editable: false
        draggable: false
        geodesic: false
        visible: true

    $scope.addNewPoint = ->
      if $scope.point.label
        angular.extend($scope.point, $scope.options.map.center)
        $scope.point.id = lastPointId++
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
    $scope.clickByPoint = (marker, eventName, model) ->
      console.log('click:' + model.label)
]).controller('DeletingPointModalController', ['$modalInstance', '$scope',
  'points', 'point', ($modalInstance, $scope, points, point) ->

    $scope.point = point

    $scope.ok = ->
      points.splice(points.indexOf(point), 1)
      $modalInstance.dismiss('ok')
    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
])