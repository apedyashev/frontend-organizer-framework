class NotificationArea extends PageComponent
  template: _.template """<div class="<%= className %>">
    <%= className %>: <%= message %>
  </div>
  """

  elements:
    notificationArea: $('#notification-area')

  # Listeners of events from another components
  listeners:
    "notification": (data)->
      @elements.notificationArea.html @template(data.notification)