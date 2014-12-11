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
        model.docMeta.bulkCreate([{doc_title: 'Test1'},{doc_title: 'Test2'}]).then () ->
          done()
    after (done) ->
      model.docMeta.drop(force: true, cascade: false).then () ->
        done()

    # TODO : 각 테스트 후 데이터를 초기화 하는 로직이 필요하다.

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
          _findResult.dataValues.doc_summary.should.be.containEql 'Test'
          done()

    it "should have Five document ", (done) ->
      @timeout 1000
      doc.getDocList (_docList) ->
        _docList.length.should.be.eql(4)
        _docList[0].dataValues.doc_title.should.be.eql('Test1')
        done()

    it "should update document" , (done) ->
      data = {}
      data.doc_title = "Test"
      data.doc_content = "### Test\n> 1.bq"
      doc.saveDoc data, (_result) ->
        updateData = _result.dataValues
        updateData.doc_title = 'Test2'
        updateData.doc_content = "### Test\n> 1.bq\n2.bq"
        doc.updateDoc updateData, (_updateResult) ->
          _updateResult.dataValues.doc_summary.should.be.containEql "2.bq"
          _updateResult.dataValues.doc_title.should.be.eql "Test"
          done()