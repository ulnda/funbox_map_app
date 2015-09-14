angular.module('app.controllers', []).controller('HomeController', ['$scope',
  '$modal', 'Point', ($scope, $modal, Point) ->

    $scope.points = []

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
      if $scope.label
        $scope.points.push Point.build($scope.label, $scope.options.map.center)
        $scope.label = null
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