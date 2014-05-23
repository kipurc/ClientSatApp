'use strict';

angular
    .module('bluelistWebBootstrapApp', [
        'ngCookies',
        'ngResource',
        'ngSanitize',
        'ngRoute'
    ])
    .constant('MBAAS_CONFIG', {
        appId: "f6dbbac9-e2ee-4233-bdc3-252cc0e7e980",
        baseUrl: "http://127.0.0.1:9000/proxy"
    })
    .config(function($routeProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'views/list.html',
                controller: 'ListCtrl'
            })
            .otherwise({
                redirectTo: '/'
            });
    })