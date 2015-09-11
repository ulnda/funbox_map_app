module = angular.module('app', ['ui.bootstrap', 'ui.router', 
  'uiGmapgoogle-maps'])

module.config(['$locationProvider', '$stateProvider', '$urlRouterProvider',
  '$httpProvider', 'uiGmapGoogleMapApiProvider', ($locationProvider,
  $stateProvider, $urlRouterProvider, $httpProvider,
  uiGmapGoogleMapApiProvider) ->

    $stateProvider.state('home'
      url: ''
      templateUrl: 'templates/home.html'
    )

    $urlRouterProvider.otherwise ($injector) ->
      $state = $injector.get('$state')
      $state.go('home')

    $locationProvider.html5Mode(true)
])
