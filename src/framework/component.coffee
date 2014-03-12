window.Rrs ?= {}

class Rrs.Component
  init: ->
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
      
      element = @elements[elementName]
      if Rrs.Util.isString element
        element = jQuery(element)
      else if Rrs.Util.isJQeryObject element
        element = jQuery(element.selector)
      else
        throw new Error "#{elementName} must be either string selector or jQuery object"

      if element.length > 0
        @elements[elementName].unbind eventName
        @elements[elementName].bind eventName, =>
          handler.call(@)
      else
        Rrs.logger.error "Unable to bind #{eventName} for #{elementName} since #{elementName} node does not exist in DOM"


  _initListeners: ->
    for listenerName, listenerCallback of @listeners
      listenerNameData = listenerName.split ":"
      if listenerNameData? and ((listenerNameData.length is 1) or (listenerNameData.length is 2))
        if listenerNameData.length is 1
          Rrs.Observer.instance().listen( null, listenerNameData[0], listenerCallback, @ )
        else if listenerNameData.length is 2
          Rrs.Observer.instance().listen( listenerNameData[0], listenerNameData[1], listenerCallback, @ )
      else
        Rrs.logger.error "Invalid listener format of name (#{listenerName}). Must be Namespace:signal"
