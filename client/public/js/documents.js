angular.module('mwv')

.config(['$stateProvider', function($stateProvider) {

  $stateProvider.state('mwv.collections.documents', {
    url   : '/:collection',
    views : {
      'documents' : {
        templateUrl : '/templates/documents.html',
        controller  : 'DocumentsCtrl as documentsCtrl',
      }
    }
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
