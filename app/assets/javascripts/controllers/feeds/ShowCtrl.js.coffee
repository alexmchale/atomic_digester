@ng.controller 'ShowFeedCtrl', ($scope, $routeParams, Feed) ->

  $scope.feed = Feed.get(id: $routeParams.id)
