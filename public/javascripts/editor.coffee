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
    .on 'click','#tempSaveBtn', ->
      Editor::event().saveDocument()

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

    saveDocument: () ->
      $.ajax
        type: 'POST'
        url: '/editor/save'
        data: {content : $('#editorView').val()},
        dataType: 'json'
        success: (result) ->
          if result.status == "OK"
            JuiEvent.notify('Success','저장되었습니다.','')
          else
            JuiEvent.notify('Fail','실패하였습니다','')

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
