angular.module('app.directives', []).directive('editInPlace', ->

  restrict: 'E'
  scope: { value: '=' }
  template: '<span ng-dblclick="activate()" ng-bind="value.label">' +
    '</span><input ng-model="newValue"></input>'
  link: ($scope, element, attrs) ->
    ENTER_KEYCODE = 13
    ESCAPE_KEYCODE = 27

    inputElement = angular.element(element.children()[1])
    element.addClass('edit-in-place')

    $scope.deactivate = ->
      element.removeClass('active')
    $scope.save = ->
      $scope.value.label = $scope.newValue
      $scope.deactivate()
      $scope.$digest()
    $scope.activate = ->
      $scope.newValue = $scope.value.label
      element.addClass('active')
      inputElement[0].focus()

    inputElement.prop 'onblur', ->
      $scope.deactivate()
    inputElement.prop 'onkeyup', (e) ->
      switch e.keyCode
        when ENTER_KEYCODE then $scope.save()
        when ESCAPE_KEYCODE then $scope.deactivate()
)