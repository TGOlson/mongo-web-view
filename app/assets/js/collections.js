angular.module('mwv')

.config(['$stateProvider', function($stateProvider) {

  $stateProvider.state('collections', {
    url: '/collections',
    templateUrl: '/templates/collections.html',
    controller: 'CollectionsCtrl as collectionsCtrl'
  });
}])

.controller('CollectionsCtrl', ['ApiSvc', function(ApiSvc) {
  var collectionsCtrl = this;

  collectionsCtrl.loading = true;

  ApiSvc.getCollections().then(setCollections);

  function setCollections(collections) {
    collectionsCtrl.collections = collections;
    collectionsCtrl.loading = false;
  }
}]);
