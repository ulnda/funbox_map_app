describe('editInPlace', function() {
  beforeEach(module('app'));

  var element, scope;

  beforeEach(inject(function(_$compile_, _$rootScope_, _Point_) {
    _$rootScope_.p = _Point_.build('SomeName', {});
    var html = '<edit-in-place data-value="p"></edit-in-place>';
    element = _$compile_(html)(_$rootScope_);
    _$rootScope_.$digest();
    scope = element.isolateScope();
  }));

  it('replace the element with the appropriate content', function() {
    var html = '<span ng-dblclick="activate()" ng-bind="value.label" ' +
      'class="ng-binding">SomeName</span>';
    expect(element.html()).toContain(html);
  });

  it('$scope.activate', function() {
    scope.activate();
    expect(scope.newValue).toEqual('SomeName');
    expect(element.hasClass('active')).toEqual(true);
  });

  it('$scope.deactivate', function() {
    scope.activate();
    scope.deactivate();
    expect(element.hasClass('active')).toEqual(false);
  });

  it('$scope.save', function() {
    var newName = 'SomeNewName';
    scope.newValue = newName;
    scope.save();
    expect(scope.value.label).toEqual(newName);
  });
});