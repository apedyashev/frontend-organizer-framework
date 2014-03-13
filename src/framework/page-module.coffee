# File: src/framework/page-module.coffee
window.Rrs ?= {}

#
# Base class for module that incapsulates page's code
#
# Interface:
#  * @create                                                [class method]  Creates class object. Allows to add components
#
# @author Alexey Pedyashev
#
# @example
#
# class SearchPage extends Rrs.PageModule
#   components:
#     search: SearchWidget.create()
#
#   # When object is being instantiated, you can pass components to the create() function:
#
# SearchPage.create
#   components:
#     userPanel: UserPanelWidget.create()
#
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

  #
  # Creates class object. Allows to add components
  #
  @create: (inProps)->
    className = Rrs.Obj.getClass(@)
    new window[className](inProps)


  #
  # Checks if all depedencies were loaded
  #
  _checkEnv: ->
    unless Rrs.Component?
      throw new Error "Rrs.Component is not defined"
