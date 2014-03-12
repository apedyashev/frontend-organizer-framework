// Generated by CoffeeScript 1.7.1
describe("Rrs.Component", function() {
  var result, search, userPanel;
  search = null;
  result = null;
  userPanel = null;
  describe("attaches signals listeners", function() {
    beforeEach(function() {
      search = new SearchWidget;
      result = new ResultWidget;
      userPanel = new UserPanelWidget;
      spyOn(result.listeners, "SearchWidget:render");
      spyOn(result.listeners, "SearchWidget:hello");
      spyOn(search.listeners, "ResultWidget:rendered");
      spyOn(search.listeners, "rendered");
      search.init();
      result.init();
      return userPanel.init();
    });
    it("when both namespace and signal name are presented", function() {
      var items, renderedResultsInfo, welcomeMessage;
      items = [1, 66, 5];
      search.emit('render', {
        items: items
      });
      welcomeMessage = "hello";
      search.emit('hello', welcomeMessage);
      renderedResultsInfo = {
        cnt: 454,
        time: 123
      };
      result.emit('rendered', renderedResultsInfo);
      expect(result.listeners["SearchWidget:render"]).toHaveBeenCalled();
      expect(result.listeners["SearchWidget:render"]).toHaveBeenCalledWith({
        items: items
      });
      expect(result.listeners["SearchWidget:hello"]).toHaveBeenCalled();
      expect(result.listeners["SearchWidget:hello"]).toHaveBeenCalledWith(welcomeMessage);
      expect(search.listeners["ResultWidget:rendered"]).toHaveBeenCalled();
      return expect(search.listeners["ResultWidget:rendered"]).toHaveBeenCalledWith(renderedResultsInfo);
    });
    it("when namespace is not presented", function() {
      var user;
      user = {
        name: 'alexey',
        lastname: 'pedyashev'
      };
      userPanel.emit('rendered', {
        user: user
      });
      return expect(search.listeners["rendered"]).toHaveBeenCalledWith({
        user: user
      });
    });
    return it("when both namespeced and non-namespaced signals with the same name are presented", function() {
      var renderedResultsInfo;
      renderedResultsInfo = {
        cnt: 454,
        time: 123
      };
      result.emit('rendered', renderedResultsInfo);
      expect(search.listeners["ResultWidget:rendered"]).toHaveBeenCalledWith(renderedResultsInfo);
      return expect(search.listeners["rendered"]).toHaveBeenCalledWith(renderedResultsInfo);
    });
  });
  return describe("attaches DOM events handlers", function() {
    search = null;
    beforeEach(function() {
      console.error('--------------');
      setUpHTMLFixture();
      search = new SearchWidget;
      return search.init();
    });
    it("invokes click event", function() {
      var spyEvent;
      spyEvent = spyOnEvent('#search-btn', 'click');
      $('#search-btn').trigger("click");
      expect('click').toHaveBeenTriggeredOn('#search-btn');
      return expect(spyEvent).toHaveBeenTriggered();
    });
    return it("invokes a handler that was assigned to click event", function() {
      $('#search-btn').trigger("click");
      return expect($('#search-btn')).toHandleWith('click', search.handlers["searchButton click"]);
    });
  });
});
