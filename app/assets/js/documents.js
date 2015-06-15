angular.module('mwv')

.config(['$stateProvider', function($stateProvider) {

  $stateProvider.state('documents', {
    url: '/collections/:collection',
    templateUrl: '/templates/documents.html',
    controller: 'DocumentsCtrl as documentsCtrl',
  });
}])

.controller('DocumentsCtrl', [function() {
  var documentsCtrl = this;

  console.log('docs');
}]);
