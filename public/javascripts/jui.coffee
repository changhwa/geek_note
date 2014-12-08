'use strict'

class JuiEvent
  constructor: () ->

  notify: (title, message, color) ->
    noti = undefined
    jui.ready ["ui.notify"], (notify) ->
      noti = notify("body",
        position: "top-right"
        event:
          show: (data) ->
            console.log "show : " + JSON.stringify(data)
            return

          hide: (data) ->
            console.log "hide : " + JSON.stringify(data)
            return

          click: (data) ->
            console.log "click : " + JSON.stringify(data)
            return

        tpl:
          item: $("#tpl_alarm").html()
      )
      noti.add({title:title, message:message, color:color})
      return
    return

jQuery ->
  window.JuiEvent = new JuiEvent()
  return
