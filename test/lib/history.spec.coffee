S = require('string')
mkdirp = require('mkdirp')
path = require('path')
gitfs = require('gift')
fs = require('fs')
rimraf = require('rimraf')
model = require("../../src/model")

Document = require("../../src/lib/document")
doc = new Document

History = require("../../src/lib/history")
his = new History

describe 'Document History Test', () ->

  before (done) ->

    storePath = path.resolve(__dirname, "../../store")
    storeSubPath = "/2014/01/01"
    fullPath = storePath + storeSubPath

    # store 폴더 생성
    mkdirp.sync fullPath, () ->
      return mkdirp.sync fullPath

    # store 폴더를 저장소로 만든다
    gitfs.init storePath, false, (err, repo) ->
      return

    model.docMeta.sync(force: true).then ->
      done()

  after (done) ->

    # store 폴더 삭제
    storePath = path.resolve(__dirname, "../../store")
    rimraf storePath, (err) ->
      if err
        throw err
    model.docMeta.drop(force: true, cascade: false).then () ->
      done()

  it '풀경로로 부터 파일이름과 경로를 분리한다', (done) ->

    storePath = path.resolve(__dirname, "../../store/2014/12/10")
    storeFullPath = storePath + "/test.txt"
    splitStandard = storeFullPath.lastIndexOf "/"
    storeFullPath.substring(0,splitStandard).should.be.eql storePath
    storeFullPath.substring(splitStandard+1,storeFullPath.length).should.be.eql 'test.txt'
    done()

  it '문서를 작성 한 후 저장소에 기록한다', (done) ->
    data = {}
    data.doc_title = "Test"
    data.doc_content = "### Test\n> 1.bq"
    doc.saveDoc data, (_result) ->
      his.save _result, (_commit) ->
        _commit.id.should.be.ok
        done()

  it '문서를 수정 한 후 저장소에 기록한다', (done) ->
    data = {}
    data.doc_title = "Test2"
    data.doc_content = "### Test\n> 3.bq"
    commitId = ''
    doc.saveDoc data, (_result) ->
      his.save _result, (_commit) ->
        commitId = _commit.id
        updateData = _result.dataValues
        updateData.doc_content = "### Test\n> 1.bq\n2.bq"
        doc.updateDoc updateData, (_updateResult) ->
          his.save _updateResult, (_updateCommit) ->
            _updateCommit.id.should.be.ok
            commitId.should.not.eql _updateCommit.id
            done()

  it '문서를 저장한 후 DB 저장한다', (done) ->
    data = {}
    data.doc_title = "Test"
    data.doc_content = "### Test\n> 1.bq"
    doc.saveDoc data, (_result) ->
      his.save _result, (_commit) ->
        model.historyMeta.build(history_commit_id: _commit.id, doc_id: _result.dataValues.doc_id).save().then (_saveResult) ->
          _saveResult.dataValues.history_commit_id.should.be.eql _commit.id
          done()
