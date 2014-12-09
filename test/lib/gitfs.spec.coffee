gitfs = require('gift')
path = require('path')
fs = require('fs')
mkdirp = require('mkdirp')
rimraf = require('rimraf')

describe 'Document History Test', () ->

  describe 'gift 학습테스트', () ->

    storePath = path.resolve(__dirname, "..") + "/store"

    before (done) ->
      # 테스트 폴더를 생성한다
      fs.mkdir storePath,  (err) ->
        # git 저장소 만든다.
        gitfs.init storePath, false, (err, repo) ->
          # 테스트 대상 파일 추가.
          data = 'simple is best!'
          fs.writeFile storePath+"/test.txt", data, 'utf8', (err) ->
            done()

    after (done) ->
      # 테스트 폴더를 삭제한다
      rimraf storePath, (err) ->
        if err
          throw err
        done()

    it "테스트폴더의 파일을 add - commit - show 한다", (done) ->
      repo = gitfs storePath
      repo.add 'test.txt', (err) ->
        repo.commit 'message',[], (err) ->
          repo.current_commit (err, commit) ->
            # show 추가함.
            repo.show commit.id + ":" +"test.txt", (err, content) ->
              content.should.be.eql 'simple is best!'
              done()

