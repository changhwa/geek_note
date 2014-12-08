express = require("express")
Parser = require("../../src/lib/parser")
Document = require("../../src/lib/document")
router = express.Router()

# GET home page.
router.get "/", (req, res) ->
  res.render "document/editor"
  return

router.post "/preview", (req,res) ->
  parse = new Parser
  parse.parse req.body.content, (_html) ->
    res.send {html: _html}

router.post "/save", (req,res) ->
  doc = new Document
  data = {}
  data.doc_content = req.body.content
  doc.saveDoc data, () ->
    res.send {status: 'OK'}

router.get "/list", (req,res) ->
  res.render "document/list"

router.get "/article", (req,res) ->
  doc = new Document
  doc.getDocList (_result) ->
    res.send {list: _result}


module.exports = router
