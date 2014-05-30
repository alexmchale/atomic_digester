@ng.controller 'StoriesCtrl', ($scope, $location, $http) ->

  $http.get('./stories.json').success (data) ->
    $scope.stories = data
