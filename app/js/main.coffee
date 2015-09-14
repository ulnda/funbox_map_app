module = angular.module('app', ['app.controllers', 'ui.bootstrap', 'ui.router', 
  'uiGmapgoogle-maps', 'dndLists'])

module.config(['$locationProvider', '$stateProvider', '$urlRouterProvider',
  '$httpProvider', 'uiGmapGoogleMapApiProvider', ($locationProvider,
  $stateProvider, $urlRouterProvider, $httpProvider,
  uiGmapGoogleMapApiProvider) ->

    uiGmapGoogleMapApiProvider.configure(
      key: 'AIzaSyCXg-YGJFM7vyOdDYcI7EZhD1SoXHwQbVg'
      libraries: 'places, geocoder'
      v: '3.17')

    $stateProvider.state('home'
      url: ''
      controller: 'HomeController'
      templateUrl: 'templates/home.html'
    )

    $urlRouterProvider.otherwise ($injector) ->
      $state = $injector.get('$state')
      $state.go('home')

    $locationProvider.html5Mode(true)
])
