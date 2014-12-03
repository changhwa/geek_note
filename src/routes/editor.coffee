express = require("express")
Parser = require("../../src/lib/parser")
router = express.Router()

# GET home page.
router.get "/", (req, res) ->
  res.render "editor/editor"
  return

router.post "/preview", (req,res) ->
  parse = new Parser
  res.send {html : parse.parse req.body.content}

module.exports = router
