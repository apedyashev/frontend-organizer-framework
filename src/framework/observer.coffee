# File: src/framework/observer.coffee

window.Rrs ?= {}

#
# Implements subscube/notify pattern
#
# Interface:
#  * @instance                                              [class method]  returns class singleton
#  * emit: (inNamespace, inSignalName, inData)              [object method] emits signal to notify subscribers
#  * listen: (inNamespace, inSignalName, callback, context) [object method] attaches event listener
#
# @author Alexey Pedyashev
#
class Rrs.Observer
  instance = null
  _listeners = {}

  # returns class singleton
  #
  @instance: ->
    instance ?= new Rrs.Observer

  constructor: ->
    # @_listeners = {}

  # emits signal to notify subscribers
  #
  # @param  inNamespace   [String]  namespace  
  # @param  inSignalName  [String]  signal name 
  # @param  inData        [Mixed]   Data to be passed to subscribers callback 
  emit: (inNamespace, inSignalName, inData)->
    namespacedSignal = "#{inNamespace}:#{inSignalName}"

    # notify namespaced subscribers
    if _listeners[namespacedSignal]?
      Rrs.logger.debug "Emitting namespaced signal #{namespacedSignal}.", _listeners
      _listeners[namespacedSignal].callback?.call(_listeners[namespacedSignal].context, inData)

    # notify subscribers which listened to signals without namespace  
    if _listeners[inSignalName]?
      Rrs.logger.debug "Emitting broadcast signal #{namespacedSignal}.", _listeners
      _listeners[inSignalName].callback?.call(_listeners[inSignalName].context, inData)


  # emits signal to notify subscribers
  #
  # @param  inNamespace   [String]      namespace  
  # @param  inSignalName  [String]      signal name 
  # @param  callback      [Function]    Callback function that is called when signal is received
  # @param  context       [Object]      Context for callback function   
  listen: (inNamespace, inSignalName, callback, context)->
    if inNamespace
      signal = "#{inNamespace}:#{inSignalName}"
    else 
      signal = inSignalName

    unless context?
      throw new Error "Conext is not set for #{signal}"

    unless callback?
      throw new Error "Callback is not set for #{signal}"

    Rrs.logger.debug "Attaching listener to #{signal} signal.", _listeners 

    _listeners[signal] = 
      callback  : callback
      context   : context
