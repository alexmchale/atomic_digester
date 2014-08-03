@ng.controller 'NewFeedCtrl', ($scope, $location, $http) ->

  $scope.submit = ->
    $http.get('./feed_searches.json', feed_search: { url: $scope.url }).success (data) ->
      console.log data
