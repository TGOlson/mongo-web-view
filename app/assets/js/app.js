angular.module('mwv', [
    'ngMaterial',
    'ui.router',
    'vendor'
  ])

.run(['$rootScope', function($rootScope) {

  $rootScope.$on('$stateChangeError', function(event, toState, toParams, fromState, fromParams, error) {

      console.error(error.stack || error);
      throw new Error('$stateChangeError: ' + error.message);
  });
}])

.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise('connect');

  $stateProvider
    .state('connect', {
      url: '/',
      templateUrl: '/templates/connect.html',
      controller: 'ConnectionCtrl as connectionCtrl'
    })
    .state('collections', {
      url: '/collections',
      templateUrl: '/templates/collections.html',
      controller: 'CollectionsCtrl as collectionsCtrl'
    })
    .state('documents', {
      url: '/collections/:collection',
      templateUrl: '/templates/documents.html',
      controller: 'DocumentsCtrl as documentsCtrl',
    });
}])


.controller('ConnectionCtrl', ['$state', 'ApiSvc', function($state, ApiSvc) {
  var connectionCtrl = this;

  console.log('Hello');
  console.log('Hello again');

  connectionCtrl.connect = function(uri) {
    ApiSvc.setMongoUri(uri);
    $state.go('collections');
  };
}])

.controller('CollectionsCtrl', ['ApiSvc', function(ApiSvc) {
  var collectionsCtrl = this;

  collectionsCtrl.loading = true;

  ApiSvc.getCollections().then(function(collections) {
    collectionsCtrl.collections = collections;
    collectionsCtrl.loading = false;
  });
}])

.controller('DocumentsCtrl', [function() {
  var documentsCtrl = this;

  console.log('docs');
}])

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
