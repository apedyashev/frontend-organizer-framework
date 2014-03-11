class SearchWidget extends Rrs.Component
  listeners: 
    "ResultWidget:rendered": (data)->
    "rendered": ->


class ResultWidget extends Rrs.Component
  listeners:
    "SearchWidget:render": (data)->
    "SearchWidget:hello": (data)->

class UserPanelWidget extends Rrs.Component
