docModel = require("../model").docMeta
Parser = require("./parser")
S = require('string')

class Document

  constructor: () ->

  saveDoc: (saveDocumentData, callback) ->
    _parseReturnPathAndSummary saveDocumentData, (_saveDocuemtData) ->
      Document::saveMeta _saveDocuemtData, callback

  updateDoc: (updateDocumentData, callback) ->
    @findByDocId updateDocumentData, (_findByResult) ->
      findResult = _findByResult.dataValues
      findResult.doc_content = updateDocumentData.doc_content
      _parseReturnPathAndSummary findResult, (_updateDocumentData) ->
        _updateDocumentData.doc_version = _updateDocumentData.doc_version + 1
        Document::updateMeta _findByResult, _updateDocumentData, callback

  _parseReturnPathAndSummary = (saveDocumentData, callback) ->
    parse = new Parser
    parse.parse saveDocumentData.doc_content, (_markupData) ->
      saveDocumentData.markup = _markupData
      if typeof saveDocumentData.doc_id != "undefined" && saveDocumentData.doc_id != null
        parse.update _markupData, saveDocumentData.doc_content, saveDocumentData.doc_path, (_path) ->
          _parseSaveAfterCallback saveDocumentData, _path, callback
      else
        parse.save _markupData, saveDocumentData.doc_content, (_path) ->
          _parseSaveAfterCallback saveDocumentData, _path, callback

  _parseSaveAfterCallback =  (saveDocumentData, _path, callback) ->
    saveDocumentData.doc_path = _path
    saveDocumentData.doc_summary = S(saveDocumentData.markup).stripTags().replaceAll('\n',' ').s
    callback saveDocumentData

  saveMeta: (data, callback) ->
    docModel.build(data).save().then (_result) ->
      callback(_result)

  updateMeta: (_model, data, callback) ->
    _model.updateAttributes(data).then (_result) ->
      callback(_result)

  findByDocId: (data, callback) ->
    docModel.find(where: doc_id: data.doc_id)
    .then (_doc) ->
      callback(_doc)

  getDocList: (callback) ->
    docModel.findAll().then (_docList) ->
      callback(_docList)

module.exports = Document
