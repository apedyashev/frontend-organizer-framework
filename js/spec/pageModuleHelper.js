// Generated by CoffeeScript 1.7.1
var SearchPage,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

window.searchCmp = SearchWidget.create();

SearchPage = (function(_super) {
  __extends(SearchPage, _super);

  function SearchPage() {
    return SearchPage.__super__.constructor.apply(this, arguments);
  }

  SearchPage.prototype.components = {
    search: searchCmp
  };

  return SearchPage;

})(Rrs.PageModule);
