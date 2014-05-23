'use strict';

var module = angular.module('bluelistWebBootstrapApp');
module.controller('ListCtrl',
    function($scope, $rootScope, $q, InitMobileServices, $location, ListService, ErrorHandler) {
        var onException = ErrorHandler.onException;
        $scope.items = [];
        $scope.listview = true;

        listItems().then(updateBindings, onException).catch(onException);

        updateBindings();

        $scope.onAddClick = function(newItem) {
            $scope.newItem = "";
            ListService.add(newItem).then(listItems, onException);
        };

        $scope.onDeleteClick = function(itemToDelete) {
            ListService.del(itemToDelete).then(listItems, onException);
        };

        $scope.onEditClick = function(itemToEdit) {
            itemToEdit.editing = true;
            $scope.editedItem = {
                obj: itemToEdit,
                origName: itemToEdit.get("name")
            };
        };

        $scope.onEditDone = function(itemToEdit, isSave) {
            var origName = itemToEdit.origName,
                obj = itemToEdit.obj;

            obj.editing = false;
            if (isSave) {
                obj.save().then(updateBindings, onException);
            } else {
                obj.set("name", origName);
            }
        };

        function updateBindings() {
            if (!$scope.$$phase) {
                $scope.$apply();
            }
        }

        function listItems() {
            return InitMobileServices.init().then(function() {
                return ListService.all().then(function(items) {
                    $scope.items = items;
                    console.log("items: %o", $scope.items);
                    return $q.when(items);
                });
            })
        };
    });