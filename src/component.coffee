class PageComponent
  init: ->
    Rrs.logger.log "PageComponent called"

    @_initHandlers()
    @_initListeners()

  emit: (inSignalName, inData)->
    sender = Rrs.Obj.getClass(@)
    Rrs.Observer.instance().emit sender, inSignalName, inData

  _initHandlers: ->
    for handlerName, handler of @handlers
      handlerData = handlerName.split(' ')
      elementName = handlerData[0]
      eventName   = handlerData[1]

      if @elements[elementName]?.length > 0
        @elements[elementName].unbind eventName
        @elements[elementName].bind eventName, =>
          handler.call(@)
      else
        Rrs.logger.error "Unable to bind #{eventName} for #{elementName} since #{elementName} does not exist"


  _initListeners: ->
    for listenerName, listenerCallback of @listeners
      listenerNameData = listenerName.split ":"
      if listenerNameData? and listenerNameData.length is 2
        Rrs.Observer.instance().listen( listenerNameData[0], listenerNameData[1], listenerCallback, @ )
      else
        Rrs.logger.error "Invalid listener format of name (#{listenerName}). Must be Namespace:signal"
