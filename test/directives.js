describe('editInPlace', function() {
  beforeEach(module('app'));

  var startValue = 'SomeValue';
  var element, scope;

  beforeEach(inject(function(_$compile_, _$rootScope_, _Point_) {
    _$rootScope_.p = _Point_.build(startValue, {});
    var html = '<edit-in-place data-value="p"></edit-in-place>';
    element = _$compile_(html)(_$rootScope_);
    _$rootScope_.$digest();
    scope = element.isolateScope();
  }));

  it('replace the element with the appropriate content', function() {
    var html = startValue;
    expect(element.html()).toContain(html);
  });

  it('$scope.activate', function() {
    scope.activate();
    expect(scope.newValue).toEqual(startValue);
    expect(element.hasClass('active')).toEqual(true);
  });

  it('$scope.deactivate', function() {
    scope.activate();
    scope.deactivate();
    expect(element.hasClass('active')).toEqual(false);
  });

  it('$scope.save', function() {
    var newValue = 'SomeNewName';
    scope.newValue = newValue;
    scope.save();
    expect(scope.value.label).toEqual(newValue);
  });
});