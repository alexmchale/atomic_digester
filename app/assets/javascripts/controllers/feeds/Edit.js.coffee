@ng.controller 'EditFeedCtrl', ($scope, $routeParams, Feed) ->

  success = (data) ->
    console.log "success, here's some data:"
    console.log data
    $scope.feed = data

  failure = (data) ->
    console.log "failure, here's some data:"
    console.log data

  assignErrors = (data) ->
    $scope.errors = data.data.errors
    console.log "-----------"
    console.log $scope.errors

  Feed.get(id: $routeParams.id, success, failure)

  $scope.update = (feed) ->
    console.log feed.$update(success, assignErrors)
