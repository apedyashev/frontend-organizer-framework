// Generated by CoffeeScript 1.7.1
var SearchPanel,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

SearchPanel = (function(_super) {
  __extends(SearchPanel, _super);

  function SearchPanel() {
    return SearchPanel.__super__.constructor.apply(this, arguments);
  }

  SearchPanel.prototype.elements = {
    searchInput: $('#search'),
    searchButton: $('#search-button')
  };

  SearchPanel.prototype.listeners = {
    "SearchResults:rendered": function(data) {
      return this.elements.searchInput.val('');
    }
  };

  SearchPanel.prototype.handlers = {
    "searchButton click": function() {
      var i, items, itemsCount, notification, searchTerm, _i;
      searchTerm = this.elements.searchInput.val();
      if (searchTerm !== '') {
        itemsCount = Math.random() * 20;
        items = [];
        for (i = _i = 0; 0 <= itemsCount ? _i <= itemsCount : _i >= itemsCount; i = 0 <= itemsCount ? ++_i : --_i) {
          items.push({
            id: i,
            title: searchTerm + "-" + i
          });
        }
        return this.emit("render", {
          items: items
        });
      } else {
        notification = {
          className: 'error',
          message: "Please enter search term (notification sent from SearchPanel)"
        };
        return this.emit('notification', {
          notification: notification
        });
      }
    }
  };

  return SearchPanel;

})(Rrs.PageComponent);
