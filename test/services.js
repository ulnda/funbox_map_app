describe('Point', function() {
  beforeEach(module('app'));

  var points = [];

  beforeEach(inject(function(_Point_) {
    var i;
    for (i = 0; i < 10; i++) {
      points.push(_Point_.build());
    }
  }));

  it('reset label value after creating a new point', function() {
    var i, length;
    for (i = 0, length = points.length; i < length; i++) {
      expect(points[i].id).toEqual(i);
    }
  });
});