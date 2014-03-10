window.Rrs ?= {}

class Rrs.Observer
  instance = null

  @instance: ->
    instance ?= new Rrs.Observer

  constructor: ->
    @_listeners = {}

  emit: (inNamespace, inSignalName, inData)->
    namespacedSignal = "#{inNamespace}:#{inSignalName}"

    # notify namespaced subscribers
    if @_listeners[namespacedSignal]?
      Rrs.logger.debug "Emitting namespaced signal #{namespacedSignal}.", @_listeners
      @_listeners[namespacedSignal].callback?.call(@_listeners[namespacedSignal].context, inData)

    # notify subscribers which listened to signals without namespace  
    if @_listeners[inSignalName]?
      Rrs.logger.debug "Emitting broadcast signal #{namespacedSignal}.", @_listeners
      @_listeners[inSignalName].callback?.call(@_listeners[inSignalName].context, inData)

  listen: (inNamespace, inSignalName, callback, context)->
    if inNamespace
      signal = "#{inNamespace}:#{inSignalName}"
    else 
      signal = inSignalName
    Rrs.logger.debug "Attaching listener to #{signal} signal.", @_listeners 

    @_listeners[signal] = 
      callback  : callback
      context   : context
