@ng = angular.module('digester', [ 'templates', 'ngRoute', 'ngSanitize', 'ngResource', 'ng-rails-csrf' ])

@ng.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/feeds'     , templateUrl: 'feed_index.html' , controller: 'FeedIndexCtrl').
    when('/feed/new'  , templateUrl: 'new_feed.html'   , controller: 'NewFeedCtrl'  ).
    when('/feeds/:id/show' , templateUrl: 'feeds/show.html' , controller: 'ShowFeedCtrl' ).
    when('/feeds/:id/edit' , templateUrl: 'feeds/edit.html' , controller: 'EditFeedCtrl' ).
    when('/stories'   , templateUrl: 'stories.html'    , controller: 'StoriesCtrl'  ).

    otherwise(templateUrl: 'home.html', controller: 'HomeCtrl')
])
