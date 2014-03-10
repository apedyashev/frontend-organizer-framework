class SearchPanel extends Rrs.PageComponent
  elements:
    searchInput   : $('#search')
    searchButton  : $('#search-button')

  listeners: 
    "SearchResults:rendered": (data)-> 
      #Erase input after rendering was finished
      @elements.searchInput.val ''

  handlers: 
    "searchButton click": -> 
      searchTerm = @elements.searchInput.val()

      if searchTerm isnt '' 
        # simulate search: generate several items
        itemsCount = Math.random() * 20
        items = []
        for i in [0..itemsCount]
          items.push 
            id    : i
            title : searchTerm + "-" + i

        @emit "render", items: items
      else
        notification = 
          className: 'error'
          message: "Please enter search term (notification sent from SearchPanel)"
        @emit 'notification', notification: notification


