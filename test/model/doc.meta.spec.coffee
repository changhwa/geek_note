model = require("../../src/model")

describe "Document Meta Model Test", ->

  it "should exists model", (done) ->
    @timeout 1000
    model.docMeta.should.be.ok
    done()
    return
