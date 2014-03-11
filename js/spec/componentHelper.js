// Generated by CoffeeScript 1.7.1
var ResultWidget, SearchWidget, UserPanelWidget,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

SearchWidget = (function(_super) {
  __extends(SearchWidget, _super);

  function SearchWidget() {
    return SearchWidget.__super__.constructor.apply(this, arguments);
  }

  SearchWidget.prototype.listeners = {
    "ResultWidget:rendered": function(data) {},
    "rendered": function() {}
  };

  return SearchWidget;

})(Rrs.Component);

ResultWidget = (function(_super) {
  __extends(ResultWidget, _super);

  function ResultWidget() {
    return ResultWidget.__super__.constructor.apply(this, arguments);
  }

  ResultWidget.prototype.listeners = {
    "SearchWidget:render": function(data) {},
    "SearchWidget:hello": function(data) {}
  };

  return ResultWidget;

})(Rrs.Component);

UserPanelWidget = (function(_super) {
  __extends(UserPanelWidget, _super);

  function UserPanelWidget() {
    return UserPanelWidget.__super__.constructor.apply(this, arguments);
  }

  return UserPanelWidget;

})(Rrs.Component);
