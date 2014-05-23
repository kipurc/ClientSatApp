'use strict';

var module = angular.module('bluelistWebBootstrapApp');
module.factory('InitMobileServices',
    function($rootScope, $q, MBAAS_CONFIG) {
        function init(){
            var appId    = MBAAS_CONFIG.appId,
                mbaasUrl = MBAAS_CONFIG.baseUrl;
            
            if ($rootScope.isMBaaSInitialized !== true){
                return IBMBaaS.initializeSDK(appId).then(function(){
                    IBMBaaS.setBaaSURL(mbaasUrl);
                    $rootScope.isMBaaSInitialized = true;
                    IBMData.initializeService();
                    console.log("IBMBaaS SDK Successfully initialized.");
                    return $q.when(IBMBaaS);
                });
            } else {
                return $q.when(IBMBaaS);
            }
        }

        return {
            init: init
        };
    }
);

module.factory('ListService', function($rootScope, $q){
    var OBJ_TYPE = "Item";
    return {
        all: function(){
            return IBMData.Query.ofType(OBJ_TYPE).find()
                .then(function(items) {
                    return $q.when(items);
                });
        },

        add: function(itemName){
            if (!itemName || !itemName.trim()){
                var reason = "Item must have name"
                return $q.reject({reason: reason});
            }
            
            var newObj = IBMData.Object.ofType(OBJ_TYPE, {
                name: itemName,
            });

            return newObj.save();
        },

        del: function(item){
            return item.del();
        }
    }
});

module.factory('ErrorHandler',function(){
    return {
        onException: function(exception){
            var errMessage = "Exception! %", logArgs = [];

            if (!exception.stack) {
                if (exception.message) {
                    logArgs.push(errMessage += "s");
                    logArgs.push(exception.message);
                } else {
                    logArgs.push(errMessage += "o");
                    logArgs.push(exception);
                }
            } else {
                logArgs = [exception.stack]
            }

            console.error.apply(console, logArgs)
        }
    };
});