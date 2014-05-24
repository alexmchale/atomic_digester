@ng.controller 'FeedIndexCtrl', [ ($scope, $location, $http) =>

  $http.get('./feeds.json').success (data) ->
    $scope.feeds = data

]
