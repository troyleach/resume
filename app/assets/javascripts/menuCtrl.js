/*
 * for the navigation menu
 */
(function() {
  'use strict';
  angular.module('app', [])

  .controller('MenuCtrl', ['$scope', function($scope) {

    $scope.hoverIn = function() {
      this.onlineResume = true;
    };

    $scope.hoverOut = function() {
      this.onlineResume = false;
    };

    $scope.leachTempIn = function() {
      this.leachTemp = true;
    };

    $scope.leachTempOut = function() {
      this.leachTemp = false;
    };

    $scope.walshTempIn = function() {
      this.walshTemp = true;
    };

    $scope.walshTempOut = function() {
      this.walshTemp = false;
    };

    $scope.attachPicIn = function() {
      this.attachPic = true;
    };

    $scope.attachPicOut = function() {
      this.attachPic = false;
    };

    $scope.contactIn = function() {
      this.contact = true;
    };

    $scope.contactOut = function() {
      this.contact = false;
    };

    // write some cool code here....message below only for testing remove
    this.message = 'Hello, MENU controller tested';
  }]);
})();
