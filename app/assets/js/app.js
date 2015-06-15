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

.config(['$urlRouterProvider', function($urlRouterProvider) {
  $urlRouterProvider.otherwise('connect');
}]);
