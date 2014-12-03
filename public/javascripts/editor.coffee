'use strict'
class Editor
  constructor: () ->
  init: () ->
    bind()
  bind = () ->
    $("#editor").off()
    .on 'click','#previewYn', ->
      that = $(@)[0]
      if that.checked
        showPreview()
        Editor::event().realTimePreview()
        return
      else
        noPreview()
    .on 'keypress','#editorView', (e) ->
      if $("#previewYn")[0].checked
        if e.which == 13 # enter key 입력시 랜더링하도록 함
          Editor::event().realTimePreview()

  event: () ->
    getPreview = (callback) ->
      $.ajax
        type: 'POST'
        url: '/editor/preview',
        data: {content : $('#editorView').val()},
        dataType: 'json',
        success: (result) ->
          callback(result.html)

    makePreview = (content) ->
      $("#previewView").html(content)

    realTimePreview: () ->
      getPreview(makePreview)

  showPreview = () ->
    $("#editorView")
    .removeClass "no-preview"
    .addClass "preview"
    $("#previewMode").show()
  noPreview = () ->
    $("#editorView")
    .removeClass "preview"
    .addClass "no-preview"
    $("#previewMode").hide()


jQuery ->
  window.Editor = new Editor()
  return
