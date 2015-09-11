module = angular.module('app', ['ui.bootstrap', 'ui.router', 
  'uiGmapgoogle-maps'])

module.config(['$locationProvider', '$stateProvider', '$urlRouterProvider',
  '$httpProvider', 'uiGmapGoogleMapApiProvider', ($locationProvider,
  $stateProvider, $urlRouterProvider, $httpProvider,
  uiGmapGoogleMapApiProvider) ->

    $locationProvider.html5Mode(true)
])
