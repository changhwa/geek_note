var sample = require('../src/sample');

describe('sample', function() {
  describe('plus test', function() {
    it('should return 3', function() {
      var result = sample.plus(1, 2);
      result.should.eql(3);
    });
  });
});
