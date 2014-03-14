Frontend organizer framework
=========

Micro framework to organize JS code for frontend applications.

### Features:
* Organizes JS code to define page bahaviour
* Reduces modules cohesion by providing **subscribe/notify** pattern
* Allows to easily extend page functionality by adding new components
* Reduces amount of code you need to write
  
### Philosofy:
* Each page has it's own `.js` file (aka page module, `PageModule class`) that tie together your widgets (or components `Component class`)
* Widgets/components are classes which are extended from `Component class`. They can:
 * init DOM elements in one place
 * attach signals listeners (**subscribe/notify** implemened by`Observer class`)
 * attach **jQuery** events handlers
 * You can write **as many components** as you need. Each component will **handle events** like button clicks and then **notify subscribed objects** (if neccessary). That way your **components do not depend on another components** and can be **reused** on another pages. Just **compose you page** using **existing** components.

### Description
All frameworks classes are defined inside of *Rrs* object.

### Classes
* PageModule - base class for module that incapsulates page's code
* Component - base class for page components. Extens your component from this class
* Observer - implements  **emmit/subscribe** functionality

### Usage

#### Page module
```coffeescript
class SearchPage extends Rrs.PageModule
  #components can be added on class declaration an later on instantiating stage 
  components:
    searchResults       : new SearchResults
    notificationArea    : new NotificationArea

$(document).ready ->
  # componetns can be added here
  searchPage =  SearchPage.create 
    # set module props
    components:
      searchPanel  : SearchPanel.create()
```

#### SearchResults component
```coffeescript
class SearchResults extends Rrs.Component
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
          message: "#{data.items.length} items have been rendered (notification sent from SearchResults)"
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
```

#### SearchPanel component

```coffeescript
class SearchPanel extends Rrs.Component
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



```

#### NotificationArea component
```coffeescript
class NotificationArea extends Rrs.Component
  template: _.template """<div class="notification <%= className %>">
    <span><%= className %>:</span> <%= message %>
  </div>
  """

  elements:
    notificationArea: $('#notification-area')

  # Listeners of events from another components
  listeners:
    "notification": (data)->
      @elements.notificationArea.html @template(data.notification)
```

 

    