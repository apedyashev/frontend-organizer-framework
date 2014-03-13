describe "Rrs.Component", ->
  search    = null
  result    = null
  userPanel = null

  describe "provides the create() function", ->
    it "to create an instance of class ", ->
      userPanel = UserPanelWidget.create()
      expect(userPanel instanceof UserPanelWidget).toBeTruthy()


    it "to creates unique instances of class", ->
      userPanel1 = UserPanelWidget.create()
      userPanel2 = UserPanelWidget.create()
       
      expect(userPanel1).not.toBe(userPanel2)


    it "to extend elements property defined in the class", ->
      searchWidget = SearchWidget.create
        elements:
          avatar: '#avatar-selector'
          name:   '#name-field'

      expect(searchWidget._elements.searchButton.selector).toEqual  '#search-btn'
      expect(searchWidget._elements.avatar).toEqual  '#avatar-selector'
      expect(searchWidget._elements.name).toEqual  '#name-field'


    it "to extend handlers property defined in the class", ->
      avatarClickHandler = -> 11
      nameFocusHandler = -> 332
      searchWidget = SearchWidget.create
        elements:
          avatar: '#avatar-selector'
          name:   '#name-field'

        handlers:
          'avatar click': avatarClickHandler
          'name focus':   nameFocusHandler

      expect(searchWidget._handlers['searchButton click']).toEqual window.searchBtnClickHandler
      expect(searchWidget._handlers['avatar click']).toEqual avatarClickHandler
      expect(searchWidget._handlers['name focus']).toEqual nameFocusHandler


    it "to extend listeners property defined in the class", ->
      signal1Listener = -> 11
      signal2Listener = -> 332
      searchWidget = SearchWidget.create
        listeners:
          'ResultWidget:signal1': signal1Listener
          'signal2':   signal2Listener

      expect(searchWidget._listeners['ResultWidget:rendered']).toEqual window.resultWidgetRenderedListener
      expect(searchWidget._listeners['rendered']).toEqual window.renderedListener
      expect(searchWidget._listeners['ResultWidget:signal1']).toEqual signal1Listener
      expect(searchWidget._listeners['signal2']).toEqual signal2Listener




  describe "throws an exception on init() function call when", ->
    it "element selector is not a sting or jQuery object", ->
      searchWidget = SearchWidget.create
        elements:
          someEl: null

        handlers:
          'someEl click': ->

      elementName = 'someEl'
      exception = new Error "#{elementName} must be either string selector or jQuery object"
      expect( -> searchWidget.init() ).toThrow exception


    it "handler's property key has incorrect format", ->
      searchWidget = SearchWidget.create
        elements:
          someEl: '.selector'

        handlers:
          #two spaces between selector name and event name
          'someEl  click': ->

      elementName = 'someEl'
      exception = new Error "#{elementName} has incorrect format. Selector name and event name must be splitted with single space"
      expect( -> searchWidget.init() ).toThrow exception

  #####################################
  #   listeners
  #####################################

  describe "attaches signals listeners", ->

    beforeEach ->

      search    = new SearchWidget
      result    = new ResultWidget
      userPanel = new UserPanelWidget

      # set spy before initialization, because listener callbacks are copied to internal Rrs.Observer prop
      # when obj is initialized. So emmitting of signal will call real callback (that was copied in init() ) 
      # instead of spy
      spyOn result._listeners, "SearchWidget:render"
      spyOn result._listeners, "SearchWidget:hello"
      spyOn search._listeners, "ResultWidget:rendered"
      spyOn search._listeners, "rendered"

      search.init()
      result.init()
      userPanel.init()

    it "when both namespace and signal name are presented", ->
      ## emit several signals
      
      items = [1, 66, 5]
      search.emit 'render', items: items
      
      welcomeMessage = "hello"
      search.emit 'hello', welcomeMessage

      renderedResultsInfo = cnt: 454, time: 123 
      result.emit 'rendered', renderedResultsInfo

      ## check that emmitted signals was received by listeners

      expect(result._listeners["SearchWidget:render"]).toHaveBeenCalled()
      expect(result._listeners["SearchWidget:render"]).toHaveBeenCalledWith( items: items )

      expect(result._listeners["SearchWidget:hello"]).toHaveBeenCalled()
      expect(result._listeners["SearchWidget:hello"]).toHaveBeenCalledWith( welcomeMessage )

      expect(search._listeners["ResultWidget:rendered"]).toHaveBeenCalled()
      expect(search._listeners["ResultWidget:rendered"]).toHaveBeenCalledWith( renderedResultsInfo )



    it "when namespace is not presented", ->
      user = 
        name: 'alexey'
        lastname: 'pedyashev'
      userPanel.emit 'rendered', user: user

      expect(search._listeners["rendered"]).toHaveBeenCalledWith( user: user )



    it "when both namespeced and non-namespaced signals with the same name are presented", ->
      renderedResultsInfo = cnt: 454, time: 123 
      result.emit 'rendered', renderedResultsInfo

      expect(search._listeners["ResultWidget:rendered"]).toHaveBeenCalledWith( renderedResultsInfo )
      expect(search._listeners["rendered"]).toHaveBeenCalledWith( renderedResultsInfo )



  #####################################
  #   DOM events
  #####################################

  describe "attaches DOM events handlers", ->
    search = null
    searchButtonSelector = null

    beforeEach ->
      setUpHTMLFixture()

      search    = new SearchWidget
      spyOn search._handlers, "searchButton click"
      # spyOn window, 'searchBtnClickHandler'  

      searchButtonSelector = search._elements.searchButton.selector

      search.init()


    afterEach ->
      $(searchButtonSelector).unbind 'click'

    

    it "invokes click event", ->
      spyEvent = spyOnEvent(searchButtonSelector, 'click')
      $(searchButtonSelector).trigger "click" 

      expect('click').toHaveBeenTriggeredOn(searchButtonSelector)
      expect(spyEvent).toHaveBeenTriggered()



    it "invokes a handler that was assigned to click event", ->
      $(searchButtonSelector).trigger "click" 
      expect(search._handlers["searchButton click"]).toHaveBeenCalled()
      # expect(window.searchBtnClickHandler).toHaveBeenCalled()



    it "DOESN'T invoke a handler that when no click occured", ->
      expect(search._handlers["searchButton click"]).not.toHaveBeenCalled()
      # expect(searchBtnClickHandler).not.toHaveBeenCalled()


    it "throws an exception when element selector is not a string or jQuery object", ->
      invalidSelector = InvalidSelectorWidget.create()


