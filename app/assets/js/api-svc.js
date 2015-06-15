angular.module('mwv')

.factory('ApiSvc', ['$http', 'R', function($http, R) {

  // var uri = null;

  // Temp default uri for development
  var uri = "mongodb://test-admin:password@ds043972.mongolab.com:43972/test-db";

  function setMongoUri(_uri) {
    uri = _uri;
  }

  function getCollections() {
    return $http.post('/api/collections', {mongoUri: uri})
      .then(R.prop('data'))
      .catch(logApiError);
  }

  function logApiError(err) {
    console.log('ApiError', err);
  }

  return {
    setMongoUri    : setMongoUri,
    getCollections : getCollections
  };

}]);
