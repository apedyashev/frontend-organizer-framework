class SearchAutocomplete extends PageComponent
  elements:
    searchInput   : $('#search')
    searchButton  : $('#search-button')

  listeners: 
    "SearchResults:refresh": (data)-> 
      console.log "Refresh signal received", data

  handlers: 
    "searchButton click": -> 
      console.log 'searchButton clicked' 
      @emit "render", {someData: 1}

