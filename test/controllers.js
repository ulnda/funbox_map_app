describe('HomeController', function() {
  beforeEach(module('app'));

  var $scope;

  beforeEach(inject(function(_$controller_, _$rootScope_){
    $scope = _$rootScope_.$new();
    _$controller_('HomeController', { $scope: $scope });
  }));

  describe('$scope.addNewPoint', function() {
    it('reset label value after creating a new point', function() {
      $scope.label = '12345';
      $scope.addNewPoint();
      expect($scope.label).toEqual(null);
    });

    describe('create a new point', function() {
      it('add a new point to the array of the points with label', function() {
        $scope.label = '12345';
        $scope.addNewPoint();
        expect($scope.points.length).toEqual(1);
      }); 

      it('not add a new point to the array of the points without label', function() {
        $scope.addNewPoint();
        expect($scope.points.length).toEqual(0);
      }); 
    });   
  });
});