class NotificationArea extends Rrs.Component
  template: _.template """<div class="notification <%= className %>">
    <span><%= className %>:</span> <%= message %>
  </div>
  """

  elements:
    notificationArea: $('#notification-area')

  # Listeners of events from another components
  listeners:
    "notification": (data)->
      @elements.notificationArea.html @template(data.notification)