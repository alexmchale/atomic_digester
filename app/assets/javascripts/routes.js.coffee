@ng = angular.module('digester', [ 'templates', 'ngRoute', 'ngSanitize' ])

@ng.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/feeds'    , templateUrl: 'feed_index.html' , controller: 'FeedIndexCtrl').
    when('/feed/new' , templateUrl: 'new_feed.html'   , controller: 'NewFeedCtrl'  ).
    when('/stories'  , templateUrl: 'stories.html'    , controller: 'StoriesCtrl'  ).

    otherwise(templateUrl: 'home.html', controller: 'HomeCtrl')
])
