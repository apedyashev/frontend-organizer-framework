class MyPageModule extends PageModule 
  components:
    # SearchAutocomplete  : new SearchAutocomplete
    searchResults       : new SearchResults

$(document).ready ->
  # pageModule = new MyPageModule 
  pageModule =  MyPageModule.create 
    # # set module props
    components:
      SearchAutocomplete  : new SearchAutocomplete





