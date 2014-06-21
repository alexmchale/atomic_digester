@ng.factory 'Feed', ($resource) ->

  $resource("/feeds/:id.json", { id: "@id" }, {
    update: { method: 'PATCH', transformRequest: (data, headersGetter) ->
      return angular.toJson(feed: data)
    }
  })
