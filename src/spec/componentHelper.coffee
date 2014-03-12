class SearchWidget extends Rrs.Component
  elements:
    searchButton: $('#search-btn')

  handlers: 
    'searchButton click': -> alert '1'

  listeners: 
    "ResultWidget:rendered": (data)->
    "rendered": ->


class ResultWidget extends Rrs.Component
  listeners:
    "SearchWidget:render": (data)->
    "SearchWidget:hello": (data)->

class UserPanelWidget extends Rrs.Component



setUpHTMLFixture = ->
  setFixtures """
    <a id="search-btn"></a>
  """
       
