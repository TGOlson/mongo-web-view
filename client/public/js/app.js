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

.config(['$urlRouterProvider', '$stateProvider', function($urlRouterProvider, $stateProvider) {
  $urlRouterProvider.otherwise('connect');

  $stateProvider.state('mwv', {
    abstract: true,
    views: {
      'navbar@': {
        templateUrl: '/templates/navbar.html'
      }
    }
  });
}]);
