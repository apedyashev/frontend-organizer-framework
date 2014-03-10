window.Rrs ?= {}

class Rrs.Observer
  instance = null

  @instance: ->
    instance ?= new Rrs.Observer

  constructor: ->
    @_listeners = {}

  emit: (inNamespace, inSignalName, inData)->
    signal = "#{inNamespace}:#{inSignalName}"
    Rrs.logger.debug "Emitting signal #{signal}.", @_listeners

    if @_listeners[signal]?
      @_listeners[signal].callback?.call(@_listeners[signal].context, inData)

  listen: (inNamespace, inSignalName, callback, context)->
    signal = "#{inNamespace}:#{inSignalName}"
    Rrs.logger.debug "Attaching listener to #{signal} signal.", @_listeners 

    @_listeners[signal] = 
      callback  : callback
      context   : context
