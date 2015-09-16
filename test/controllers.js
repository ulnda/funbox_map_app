describe('HomeController', function() {
  beforeEach(module('app'));

  var $scope;
  var modal;

  beforeEach(inject(function(_$controller_, _$rootScope_) {
    $scope = _$rootScope_.$new();
    modal = jasmine.createSpyObj('modal', ['open']);
    _$controller_('HomeController', { $scope: $scope, $modal: modal });
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

      it('not add a new point to the array of the points without label', 
        function() {
          $scope.addNewPoint();
          expect($scope.points.length).toEqual(0);
      }); 
    });   
  });

  describe('$scope.removePoint', function() {
    it('show modal window for point deleting', function() {
      $scope.removePoint();
      expect(modal.open).toHaveBeenCalled();
    });   
  });

  describe('$scope.geocode', function() {
    var geocoder;
    var address = 'Address';

    beforeEach(inject(function() {
      geocoder = {
        geocode: function(location, callback) {
          var results = [];
          var status;
          if (location.location !== null) {
            results.push({ formatted_address: address });
            status = google.maps.GeocoderStatus.OK;
          }
          callback(results, status);
        }
      };
      spyOn(geocoder, 'geocode').and.callThrough();
    }));

    it('show result address message', function() {
      var location = { location: { lat: 45, lng: -73 } }
      $scope.geocode(geocoder, location);
      expect($scope.searched).toEqual(true);
      expect($scope.address).toEqual(address);
    });  

    it('show no result address message', function() {
      $scope.geocode(geocoder, null);
      expect($scope.searched).toEqual(true);
      expect($scope.address).toEqual(undefined);
    }); 
  })
});

describe('DeletingPointModalController', function() {
  beforeEach(module('app'));

  var $scope;
  var points;
  var point;
  var modalInstance;

  beforeEach(inject(function(_$controller_, _$rootScope_, _Point_, _$modal_) {
    $scope = _$rootScope_.$new();
    points = [];
    point = _Point_.build('PointName', { latitude: 0, longitude: 0 });
    points.push(point);
    modalInstance = jasmine.createSpyObj('modalInstance', ['close', 'dismiss']);
    _$controller_('DeletingPointModalController', { $scope: $scope, 
      points: points, point: point, $modalInstance: modalInstance });
  }));

  describe('$scope.ok', function() {
    it('remove point from points and close window', function() {
      $scope.ok();
      expect(points.length).toEqual(0);
      expect(modalInstance.dismiss).toHaveBeenCalledWith('ok');
    });  
  });

  describe('$scope.cancel', function() {
    it('close window without deleting point', function() {
      $scope.cancel();
      expect(points.length).toEqual(1);
      expect(modalInstance.dismiss).toHaveBeenCalledWith('cancel');
    });  
  }); 
});