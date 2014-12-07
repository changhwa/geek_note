docModel = require("../model").docMeta
Parser = require("./parser")
S = require('string')

class Document
  constructor: () ->
  saveDoc: (saveDocumentData, callback) ->
    parse = new Parser
    @saveMeta saveDocumentData, () ->
      parse.parse saveDocumentData.doc_content, (_markupData) ->
        saveDocumentData.markup = _markupData
        parse.save _markupData, saveDocumentData.doc_content, (_path) ->
          saveDocumentData.doc_path = _path
          saveDocumentData.doc_summary = S(saveDocumentData.markup).stripTags().replaceAll('\n',' ').s
          Document::saveMeta saveDocumentData, callback
  saveMeta: (data, callback) ->
    docModel.build(data).save().then (_result) ->
      callback(_result)
  findByDocId: (data, callback) ->
    docModel.find(where: doc_id: data.doc_id)
    .then (_doc) ->
      callback(_doc)
  getDocList: (callback) ->
    docModel.findAll().then (_docList) ->
      callback(_docList)

module.exports = Document
