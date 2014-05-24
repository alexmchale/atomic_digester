@ng = angular.module('digester', [ 'templates', 'ngRoute' ])

@ng.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/feeds', {
      templateUrl: 'feed_index.html',
      controller: 'FeedIndexCtrl'
    }).
    otherwise({
      templateUrl: '../templates/home.html',
      controller: 'HomeCtrl'
    })
])
