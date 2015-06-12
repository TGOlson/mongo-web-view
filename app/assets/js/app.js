angular.module('mwv', [
    'ngMaterial',
    'ui.router'
  ])

.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise('/');
  //
  // Now set up the states
  $stateProvider
    .state('connect', {
      url: '/',
      templateUrl: '/templates/connect.html',
      controller: 'ConnectionCtrl as connectionCtrl'
    });
}])


.controller('ConnectionCtrl', [function() {
  var connectionCtrl = this;

  console.log('Hello');
  console.log('Hello again');

  connectionCtrl.connect = function(connectionString) {
    console.log(connectionString);
  };
}])

.factory('DbSvc', [function($http) {

  var config = null;

  function setConfig(_config) {
    config = _config;
  }

  function getCollections() {
    $http.post('/collections', config).then(function(response) {
      console.log(response);
    });
  }

}]);
