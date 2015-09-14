angular.module('app.controllers', []).controller('HomeController', ['$scope',
  '$modal', ($scope, $modal) ->

    ICON_MARKER = 'img/marker.png'

    $scope.points = []
    $scope.options =
      map:
        center:
          latitude: 45
          longitude: -73
        zoom: 16
      point:
        draggable: true

    $scope.addNewPoint = ->
      if $scope.point.label
        $scope.point.icon = ICON_MARKER
        $scope.point.id = $scope.points.length
        angular.extend($scope.point, $scope.options.map.center)
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

    $scope.options.point.events = {}
    $scope.options.point.events.click = (marker, eventName, model) ->
      console.log('click:' + model.label)
    $scope.options.point.events.dragend = (marker, eventName, model) ->
      console.log('drag:' + model.label)
]).controller('DeletingPointModalController', ['$modalInstance', '$scope',
  'points', 'point', ($modalInstance, $scope, points, point) ->

    $scope.point = point

    $scope.ok = ->
      points.splice(points.indexOf(point), 1)
      $modalInstance.dismiss('ok')
    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
])