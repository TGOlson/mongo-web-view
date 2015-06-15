angular.module('mwv')

.directive('mwvDoc', function() {
  return {
    restrict: 'E',
    controller: 'DocCtrl as docCtrl',
    scope: {
      doc: '='
    },
    templateUrl: '/templates/doc.html'
  };
})

.controller('DocCtrl', ['$scope', function($scope) {
  var docCtrl = this;

  docCtrl.expanded = false;

  docCtrl.doc = $scope.doc;

  docCtrl.toggle = function() {
    docCtrl.expanded = !docCtrl.expanded;
  };

}]);
