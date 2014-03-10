// Generated by CoffeeScript 1.7.1
var NotificationArea,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NotificationArea = (function(_super) {
  __extends(NotificationArea, _super);

  function NotificationArea() {
    return NotificationArea.__super__.constructor.apply(this, arguments);
  }

  NotificationArea.prototype.template = _.template("<div class=\"notification <%= className %>\">\n  <span><%= className %>:</span> <%= message %>\n</div>");

  NotificationArea.prototype.elements = {
    notificationArea: $('#notification-area')
  };

  NotificationArea.prototype.listeners = {
    "notification": function(data) {
      return this.elements.notificationArea.html(this.template(data.notification));
    }
  };

  return NotificationArea;

})(PageComponent);
