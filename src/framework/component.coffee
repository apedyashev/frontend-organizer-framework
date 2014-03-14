# File: src/framework/component.coffee

window.Rrs ?= {}

#
# Base class for page components/widgets
#
# Interface:
#  * @create                      [class method]  Creates class object. May accept elements, handlers and listeners as hash
#  * init:                        [object method] Initializes component
#  * emit(inSignalName, inData):  [object method] Notify subscribed objects about some event
#
# @author Alexey Pedyashev
#
# @example 
#
#   class SearchWidget extends Rrs.Component
#     elements:
#       # either string selector or jQuery objects are allowed
#       searchButton: '#search-btn'
#
#     # handlers for events of elements defined in the 'elements' property
#     handlers:
#       'searchButton click': -> console.log 'clicked'
#
#     # subscribe to signals from another components
#     listeners:
#       # listen to signals from instances of SearchResults class only
#       'SearchResults:rendered': (data)-> 
#         console.log 'the rendered signal fron instance of SearchResults class was receveid with data', data  
#       # listen to signals from any objects
#       'render-search': ->
#         console.log 'the render-search signal was received'
#
#     # When object is being instantiated, you can pass the same properties to the create finction to add more
#     # elements, handlers and listeners
#     search = SearchWidget.create(
#       elements:
#         #....
#       handlers:
#         #....
#       listeners:
#         #....
#
class Rrs.Component

  constructor: (inProps)->
    @_elements   = Rrs.Obj.extend @_elements,  @elements 
    @_listeners  = Rrs.Obj.extend @_listeners, @listeners 
    @_handlers   = Rrs.Obj.extend @_handlers,  @handlers 

    @_elements   = Rrs.Obj.extend(@_elements, inProps.elements)    if inProps?.elements?
    @_listeners  = Rrs.Obj.extend(@_listeners, inProps.listeners)  if inProps?.listeners?
    @_handlers   = Rrs.Obj.extend(@_handlers, inProps.handlers)    if inProps?.handlers?


  #
  # Creates class object. May accept elements, handlers and listeners as hash
  #
  # @param [Hash]   inProps     Accepts hash of{elements, listeners, handlers}
  #
  @create: (inProps)->
    className = Rrs.Obj.getClass(@)
    new window[className](inProps)

  #
  # Initializes component
  #
  init: ->
    @_initHandlers()
    @_initListeners()

  #
  # Notify subscribed objects about some event
  #
  # @param   [String]  inSignalName    string with signal name
  # @param    [Hash]    inData          Event data to be sent 
  #
  emit: (inSignalName, inData)->
    sender = Rrs.Obj.getClass(@)
    Rrs.Observer.instance().emit sender, inSignalName, inData


  #
  # Initializes handlers
  #
  _initHandlers: ->
    for handlerName, handler of @_handlers
      handlerData = handlerName.split(' ')
      elementName = handlerData[0]
      eventName   = handlerData[1]  

      if handlerData.length isnt 2
        throw new Error "#{elementName} has incorrect format. Selector name and event name must be splitted with single space"
      
      
      element = @_elements[elementName]
      if Rrs.Obj.isString element
        element = jQuery(element)
      else if Rrs.Obj.isJQeryObject element
        element = jQuery(element.selector)
      else
        throw new Error "#{elementName} must be either string selector or jQuery object"

      if element.length > 0
        @_elements[elementName].unbind eventName
        @_elements[elementName].bind eventName, =>
          #handler must be bound to object's context
          handler.call(@)
      else
        Rrs.logger.error "Unable to bind #{eventName} for #{elementName} since #{elementName} node does not exist in DOM"


  #
  # Initializes signals listeners
  #
  _initListeners: ->
    for listenerName, listenerCallback of @_listeners
      listenerNameData = listenerName.split ":"
      if listenerNameData? and ((listenerNameData.length is 1) or (listenerNameData.length is 2))
        if listenerNameData.length is 1
          Rrs.Observer.instance().listen( null, listenerNameData[0], listenerCallback, @ )
        else if listenerNameData.length is 2
          Rrs.Observer.instance().listen( listenerNameData[0], listenerNameData[1], listenerCallback, @ )
      else
        Rrs.logger.error "Invalid listener format of name (#{listenerName}). Must be Namespace:signal"
