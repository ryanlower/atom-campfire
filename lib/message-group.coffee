{View} = require 'atom'

module.exports =
class MessageGroup
  constructor: (@user) ->
    @messages = []

  addMessage: (message) ->
    @messages.push message

