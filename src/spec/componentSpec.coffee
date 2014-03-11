describe "Rrs.Component", ->

  search    = null
  result    = null
  userPanel = null

  describe "attaches signals listeners", ->

    beforeEach ->

      search    = new SearchWidget
      result    = new ResultWidget
      userPanel = new UserPanelWidget

      # set spy before initialization, because listener callbacks are copied to internal Rrs.Observer prop
      # when obj is initialized. So emmitting of signal will call real callback (that was copied in init() ) 
      # instead of spy
      spyOn result.listeners, "SearchWidget:render"
      spyOn result.listeners, "SearchWidget:hello"
      spyOn search.listeners, "ResultWidget:rendered"
      spyOn search.listeners, "rendered"

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

      expect(result.listeners["SearchWidget:render"]).toHaveBeenCalled()
      expect(result.listeners["SearchWidget:render"]).toHaveBeenCalledWith( items: items )

      expect(result.listeners["SearchWidget:hello"]).toHaveBeenCalled()
      expect(result.listeners["SearchWidget:hello"]).toHaveBeenCalledWith( welcomeMessage )

      expect(search.listeners["ResultWidget:rendered"]).toHaveBeenCalled()
      expect(search.listeners["ResultWidget:rendered"]).toHaveBeenCalledWith( renderedResultsInfo )



    it "when namespace is not presented", ->
      user = 
        name: 'alexey'
        lastname: 'pedyashev'
      userPanel.emit 'rendered', user: user

      expect(search.listeners["rendered"]).toHaveBeenCalledWith( user: user )



    it "when both namespeced and non-namespaced signals with the same name are presented", ->
      renderedResultsInfo = cnt: 454, time: 123 
      result.emit 'rendered', renderedResultsInfo

      expect(search.listeners["ResultWidget:rendered"]).toHaveBeenCalledWith( renderedResultsInfo )
      expect(search.listeners["rendered"]).toHaveBeenCalledWith( renderedResultsInfo )


  describe "attaches DOM events handlers", ->