window.searchBtnClickHandler = -> 123
window.resultWidgetRenderedListener = -> 456
window.renderedListener = -> 456

class SearchWidget extends Rrs.Component
  elements:
    searchButton: $('#search-btn')

  handlers: 
    'searchButton click': searchBtnClickHandler #->  

  listeners: 
    "ResultWidget:rendered": resultWidgetRenderedListener
    "rendered": renderedListener


class ResultWidget extends Rrs.Component
  listeners:
    "SearchWidget:render": (data)->
    "SearchWidget:hello": (data)->

class UserPanelWidget extends Rrs.Component


class InvalidSelectorWidget extends Rrs.Component
  elements:
    someEl: '.el-class'
    searchButton: null

  handlers: 
    'someEl click': ->  
    'searchButton click': ->  



setUpHTMLFixture = ->
  # setFixtures """
  #   <a id="search-btn"></a>
  # """
       
class B
  test: ->
    console.error '^^^^^^^^^^^^^', @p

class D
  p: 1

$(document).ready ->
  new D