window.Rrs ?= {}

class Rrs.PageModule 
  _props = {}

  constructor: (inProps)->
    _props = inProps

    @_checkEnv()

    @_components = Rrs.Obj.extend(@_components, @components)
    @_components = Rrs.Obj.extend(@_components, _props.components) if _props?.components?

    for cmpName, cmp  of @_components 
      if cmp instanceof Rrs.Component
        cmp.init()
      else
        Rrs.logger.error "#{cmp.toString()} is not an instance of Component"

  @create: (inProps)->
    className = Rrs.Obj.getClass(@)
    new window[className](inProps)


  _checkEnv: ->
    unless Rrs.Component?
      throw new Error "Rrs.Component is not defined"
