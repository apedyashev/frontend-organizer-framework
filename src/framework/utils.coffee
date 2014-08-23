# File: src/framework/utils.coffee

window.Rrs ?= {}

#
# Allows to add mixins to class
#
# @param [class] base       Base class
# @param [class] mixins...  Mixin classes
#  
# @author Alexey Pedyashev
#
# @example
#
# class DeeperThought extends mixOf DeepThought, PhilosopherMixin
#
Rrs.mixOf = (base, mixins...) ->
  class Mixed extends base
  for mixin in mixins by -1 #earlier mixins override later ones
    for name, method of mixin::
      Mixed::[name] = method
  Mixed

# 
# Object utility
# 
# @interface:
#  * getClass(inObject)             returns class name of object (for class names or class inctanses) or typeof object      
#  * extend(object, properties)     copies functions and props from properties to object
#  * isString(object)               returns true if 'object' is a string
#  * isObject(object)               returns true if 'object' is an object
#  * isFunction(object)             returns true if 'object' is a function
#  * isJQeryObject(object)          returns true if 'object' is a jQuery object
#
Rrs.Obj =
  #
  # Returns class name of object (for class names or class inctanses) or typeof object
  # 
  getClass: (inObject)->
    objectType =  (typeof inObject).toLowerCase()
    if objectType is "function"
      className = /^function\s(\w+)/.exec(inObject)[1]
    else if objectType is "object"
      className = /(\w+)\(/.exec(inObject.constructor.toString())[1]
    else
     className = typeof inObject  

    className

  #
  # Copies functions and props from properties to object
  #
  extend: (object, properties) ->
    object      = {} unless object?  
    properties  = {} unless properties?
    for key, val of properties
      object[key] = val
    object

  #
  # Returns true if 'object' is a string
  #
  isString: (object)->
    (typeof object).toLowerCase() is 'string'

  #
  # Returns true if 'object' is an object
  #
  isObject: (object)->
    (typeof object).toLowerCase() is 'object'

  #
  # Returns true if 'object' is a function
  #
  isFunction: (object)->
    (typeof object).toLowerCase() is 'function'

  #
  # Returns true if 'object' is a jQuery object
  #
  isJQeryObject: (object)->
    object instanceof jQuery

  uniqueId: (length) ->
    id = undefined
    length = 8  unless length?
    id = ""
    id += Math.random().toString(36).substr(2)  while id.length < length
    id.substr 0, length