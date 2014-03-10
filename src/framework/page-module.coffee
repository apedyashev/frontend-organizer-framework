window.Rrs ?= {}

class Rrs.PageModule 
  _props = {}

  constructor: (inProps)->
    _props = inProps

    @_checkEnv()

    #if 'components' is not defined in derived class then init it
    @components = {} unless @components?

    jQuery.extend(@components, _props.components) if _props?.components?

    for cmpName, cmp  of @components 
      if cmp instanceof Rrs.PageComponent
        cmp.init()
      else
        Rrs.logger.error "#{cmp.toString()} is not an instance of PageComponent"

  @create: (inProps)->
    className = Rrs.Obj.getClass(@)
    new window[className](inProps)


  _checkEnv: ->
    unless Rrs.PageComponent?
      throw new Error "Rrs.PageComponent is not defined"
