'use strict'

process.env.NODE_ENV = 'test'
path = require('path')
fs = require('fs')
model = require("../../src/model")
Document = require("../../src/lib/document")
doc = new Document


describe 'Document Lib Test', () ->
  describe 'Document Meta Data Test', () ->
    before (done) ->
      model.docMeta.sync(force: true).then ->
        done()
    it "should save document meta data", (done) ->
      @timeout 1000
      data = {}
      data.doc_title = "Test"
      data.doc_path = "/store/2014/11/20/test"
      doc.saveMeta data, (_save) ->
        doc.findByDocId
          doc_id: _save.doc_id, (_result) ->
            _result.dataValues.doc_id.should.eql _save.doc_id
            done()

    it "should save document meta data before create markdown file", (done) ->
      @timeout 1000
      data = {}
      data.doc_title = "Test"
      data.doc_content = "### Test\n> 1.bq"
      doc.saveDoc data, (_result) ->
        result = _result.dataValues
        result.doc_title.should.eql data.doc_title
        result.doc_path.should.be.ok
        doc.findByDocId doc_id: result.doc_id, (_findResult) ->
          _findResult.dataValues.doc_id.should.eql result.doc_id
          done()