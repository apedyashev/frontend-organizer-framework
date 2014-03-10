// Generated by CoffeeScript 1.7.1
var SearchResults,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

SearchResults = (function(_super) {
  __extends(SearchResults, _super);

  function SearchResults() {
    return SearchResults.__super__.constructor.apply(this, arguments);
  }

  SearchResults.prototype.elements = {
    resultsContainer: $('#res-container')
  };

  SearchResults.prototype.template = _.template("<tr>\n  <td>#<%= id %></td><td><%= title %></td>\n</tr>");

  SearchResults.prototype.listeners = {
    "SearchPanel:render": function(data) {
      var item, notification, _i, _len, _ref;
      this.elements.resultsContainer.html('');
      if (data.items != null) {
        _ref = data.items;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          this.elements.resultsContainer.append(this.template(item));
        }
        this.emit("rendered");
        notification = {
          className: 'success',
          message: "" + data.items.length + " items has been rendered"
        };
      } else {
        notification = {
          className: 'error',
          message: "There are no items to render"
        };
      }
      return this.emit("notification", {
        notification: notification
      });
    }
  };

  return SearchResults;

})(PageComponent);
