_ = require 'underscore-plus'
{Emitter} = require 'emissary'

module.exports =
class MessageGroup extends Emitter
  constructor: (@user, message) ->
    @messages = [message]

  # Add new message to group if by same user
  # And within 5 minutes of the first message
  addMessageToGroup: (message) ->
    @user.id == message.userId &&
      message.createdAt - @firstMessage().createdAt < 300000

  addMessage: (message) ->
    @messages.push message
    @emit 'new_message', message

  firstMessage: ->
    _.first @messages
