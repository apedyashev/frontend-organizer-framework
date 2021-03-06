// Generated by CoffeeScript 1.7.1
describe("Rrs.PageModule", function() {
  describe("provides the create() function", function() {
    it("to create an instance of class", function() {
      var searchPage;
      searchPage = SearchPage.create();
      return expect(searchPage instanceof SearchPage).toBeTruthy();
    });
    it("to creates unique instances of class", function() {
      var searchPage1, searchPage2;
      searchPage1 = SearchPage.create();
      searchPage2 = SearchPage.create();
      return expect(searchPage1).not.toBe(searchPage2);
    });
    return it("to merge components added on class declaration and passed to the create() function", function() {
      var searchPage, searchResults, userPanel;
      searchResults = ResultWidget.create();
      userPanel = UserPanelWidget.create();
      searchPage = SearchPage.create({
        components: {
          searchResults: searchResults,
          userPanel: userPanel
        }
      });
      expect(searchPage._components.search).toEqual(window.searchCmp);
      expect(searchPage._components.searchResults).toEqual(searchResults);
      return expect(searchPage._components.userPanel).toEqual(userPanel);
    });
  });
  return describe("calls the init() function of components", function() {
    it("for components added on class declaration", function() {
      var searchPage;
      spyOn(window.searchCmp, 'init');
      searchPage = SearchPage.create();
      return expect(searchPage._components.search.init).toHaveBeenCalled();
    });
    return it("for components added on class declaration and passed to the create() function", function() {
      var searchPage, searchResults, userPanel;
      searchResults = ResultWidget.create();
      userPanel = UserPanelWidget.create();
      spyOn(window.searchCmp, 'init');
      spyOn(searchResults, 'init');
      spyOn(userPanel, 'init');
      searchPage = SearchPage.create({
        components: {
          searchResults: searchResults,
          userPanel: userPanel
        }
      });
      expect(searchPage._components.searchResults.init).toHaveBeenCalled();
      expect(searchPage._components.userPanel.init).toHaveBeenCalled();
      return expect(searchPage._components.search.init).toHaveBeenCalled();
    });
  });
});
