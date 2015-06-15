angular.module('mwv')

.config(['$stateProvider', function($stateProvider) {

  $stateProvider.state('collections.documents', {
    url: '/collections/:collection',
    templateUrl: '/templates/documents.html',
    controller: 'DocumentsCtrl as documentsCtrl',
  });
}])

.controller('DocumentsCtrl', ['$stateParams', 'ApiSvc', function($stateParams, ApiSvc) {
  var documentsCtrl = this;

  documentsCtrl.loading = true;

  ApiSvc.getDocuments($stateParams.collection).then(setDocuments);

  function setDocuments(documents) {
    documentsCtrl.documents = documents;
    documentsCtrl.loading = false;
  }
}]);
