window.Rrs ?= {}

Rrs.mixOf = (base, mixins...) ->
  class Mixed extends base
  for mixin in mixins by -1 #earlier mixins override later ones
    for name, method of mixin::
      Mixed::[name] = method
  Mixed

class Rrs.Obj
  @getClass: (inObject)->
    objectType =  (typeof inObject).toLowerCase()
    if objectType is "function"
      className = /^function\s(\w+)/.exec(inObject)[1]
    else if objectType is "object"
      className = /(\w+)\(/.exec(inObject.constructor.toString())[1]
    else
     className = false

    className

  @extend: (object, properties) ->
    object      = {} unless object?
    properties  = {} unless properties?
    for key, val of properties
      object[key] = val
    object

Rrs.Util =
  isString: (object)->
    (typeof object).toLowerCase() is 'string'

  isObject: (object)->
    (typeof object).toLowerCase() is 'object'

  isFunction: (object)->
    (typeof object).toLowerCase() is 'function'

  isJQeryObject: (object)->
    object instanceof jQuery