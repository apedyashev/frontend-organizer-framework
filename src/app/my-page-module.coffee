class SearchPage extends Rrs.PageModule
  #components can be added on class declaration an later on instantiating stage 
  components:
    searchResults    : SearchResults.create()
    notificationArea : NotificationArea.create()

$(document).ready ->
  # componetns can be added here
  searchPage =  SearchPage.create 
    # set module props
    components:
      searchPanel  : SearchPanel.create()
 