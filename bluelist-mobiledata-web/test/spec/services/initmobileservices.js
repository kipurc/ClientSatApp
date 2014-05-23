'use strict';

describe('Service: initMobileServices', function () {

  // load the service's module
  beforeEach(module('bluelistWebBootstrapApp'));

  // instantiate service
  var initMobileServices;
  beforeEach(inject(function (_initMobileServices_) {
    initMobileServices = _initMobileServices_;
  }));

  it('should do something', function () {
    expect(!!initMobileServices).toBe(true);
  });

});
