class MyPageModule extends PageModule 
  components:
    searchResults       : new SearchResults
    notificationArea    : new NotificationArea

$(document).ready ->
  # pageModule = new MyPageModule 
  pageModule =  MyPageModule.create 
    # # set module props
    components:
      searchPanel  : new SearchPanel





