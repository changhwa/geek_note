docModel = require("../model").docMeta

class Document
  constructor: () ->
  save: (data, callback) ->
    docModel.build(data).save().then (_result) ->
      callback(_result.dataValues)
  findByDocId: (data, callback) ->
    docModel.find(where: doc_id: data.doc_id)
    .then (_doc) ->
      callback(_doc)

module.exports = Document
