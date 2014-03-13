describe "Rrs.PageModule", ->
  describe "provides the create() function", ->
    it "to create an instance of class", ->
      searchPage = SearchPage.create()
      expect(searchPage instanceof SearchPage).toBeTruthy()

    it "to creates unique instances of class", ->
      searchPage1 = SearchPage.create()
      searchPage2 = SearchPage.create()
       
      expect(searchPage1).not.toBe(searchPage2)

    it "to merge components added on class declaration and passed to the create() function", ->
      searchResults = ResultWidget.create()
      userPanel     = UserPanelWidget.create()

      searchPage = SearchPage.create
        components:
          searchResults: searchResults
          userPanel: userPanel

      expect(searchPage._components.search).toEqual window.searchCmp
      expect(searchPage._components.searchResults).toEqual searchResults
      expect(searchPage._components.userPanel).toEqual userPanel

  describe "calls the init() function of components", ->

    it "for components added on class declaration", ->
      spyOn window.searchCmp, 'init'
      searchPage = SearchPage.create()

      expect(searchPage._components.search.init).toHaveBeenCalled()

    it "for components added on class declaration and passed to the create() function", ->
      searchResults = ResultWidget.create()
      userPanel     = UserPanelWidget.create()

      spyOn window.searchCmp, 'init'
      spyOn searchResults, 'init'
      spyOn userPanel, 'init'

      searchPage = SearchPage.create
        components:
          searchResults: searchResults
          userPanel: userPanel

      expect(searchPage._components.searchResults.init).toHaveBeenCalled()
      expect(searchPage._components.userPanel.init).toHaveBeenCalled()
      expect(searchPage._components.search.init).toHaveBeenCalled()


