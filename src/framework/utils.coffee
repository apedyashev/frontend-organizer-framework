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