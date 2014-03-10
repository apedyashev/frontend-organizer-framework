class SearchResults extends PageComponent
  elements:
    resultsContainer: $('#res-container')

  listeners:
    "SearchAutocomplete:render": (data)->
      console.debug 'Received SearchAutocomplete:render', data
      @emit "refresh", {refreshData: "blabla"}