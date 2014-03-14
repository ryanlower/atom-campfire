_ = require 'underscore-plus'
{Emitter} = require 'emissary'

module.exports =
class MessageGroup extends Emitter
  constructor: (@user) ->
    @messages = []

  # Add new message to group if by same user
  # And within 5 minutes of the first message
  addMessageToGroup: (message) ->
    @user.id == message.userId &&
      message.createdAt - _.first(@messages).createdAt < 300000

  addMessage: (message) ->
    @messages.push message
    @emit 'new_message', message
