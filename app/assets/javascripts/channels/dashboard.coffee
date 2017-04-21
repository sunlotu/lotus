App.dashboard = App.cable.subscriptions.create "DashboardChannel",
  connected: ->
    @follow()
    
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('.dashboard').append data.dashboard
    # Called when there's incoming data on the websocket for this channel

  follow: ->
    @perform 'follow'
