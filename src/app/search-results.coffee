class SearchResults extends PageComponent
  elements:
    resultsContainer: $('#res-container')

  template: _.template """<tr>
    <td>#<%= id %></td><td><%= title %></td>
  </tr>
  """

  # Listeners of events from another components
  listeners:
    "SearchPanel:render": (data)->
      #SearchAutocomplete send us list if found items to be rendered
      # Render them using underscore.js template
      @elements.resultsContainer.html('')
      if data.items?
        for item in data.items
          @elements.resultsContainer.append @template(item)

        #notify all subscribed objects that rendering has been completed
        @emit "rendered"

        notification =
          className: 'success'
          message: "#{data.items.length} items has been rendered (notification sent from SearchResults)"
      else
        notification = 
          className: 'error'
          message: "There are no items to render (notification sent from SearchResults)"

      # notify any subscribed object about rendering result
      # if instance of SearchAutocomplete class (or any another component) are subsribed to this signal, 
      # then they are able to proccess it
      #
      # NOTE: namespace will be prepended automatically. So to subscript on this event you need to listen to
      # 'SearchResults:error' signal
      @emit "notification", notification: notification

