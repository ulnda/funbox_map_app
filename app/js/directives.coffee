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

    deactivate = ->
      element.removeClass('active')
    save = ->
      $scope.value.label = $scope.newValue
      deactivate()
      $scope.$digest()
    $scope.activate = ->
      $scope.newValue = $scope.value.label
      element.addClass('active')
      inputElement[0].focus()

    inputElement.prop 'onblur', ->
      deactivate()
    inputElement.prop 'onkeyup', (e) ->
      save() if e.keyCode is ENTER_KEYCODE
      deactivate() if e.keyCode is ESCAPE_KEYCODE
)