request = require 'request'
fs = require 'fs'

config = JSON.parse fs.readFileSync "#{__dirname}/../config.json"
stanfordSimpleNlpConfig = config.stanfordSimpleNlp
nlpServerUrl = stanfordSimpleNlpConfig.serverUrl


parse = (sourceText, callback) ->
  request
    url: "#{nlpServerUrl}/parse"
    method: 'POST'
    form:
      sourceText: sourceText
    json: true
    timeout: 0
    headers:
      Connection: 'Keep-Alive'
  ,
    (err, resp, body) ->
      return callback err  if err?

      if resp.statusCode isnt 200
        return callback new Error "#{resp.statusCode} - #{body}"

      callback null, body



module.exports = parse
