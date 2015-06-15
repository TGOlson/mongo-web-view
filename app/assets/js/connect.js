angular.module('mwv')

.config(['$stateProvider', function($stateProvider) {

  $stateProvider.state('connect', {
    url: '/connect',
    templateUrl: '/templates/connect.html',
    controller: 'ConnectionCtrl as connectionCtrl'
  });
}])

.controller('ConnectionCtrl', ['$state', 'ApiSvc', function($state, ApiSvc) {
  var connectionCtrl = this;

  connectionCtrl.connect = function(uri) {
    ApiSvc.setMongoUri(uri);
    $state.go('collections');
  };
}]);
