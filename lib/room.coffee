_ = require 'underscore-plus'
{Emitter} = require 'emissary'

module.exports =
class Room extends Emitter
  constructor: (@room) ->
    @messages = []
    @_get_current_messages()
    @_listen_for_new_messages()

  addMessages: (messages) ->
    if _.isArray messages
      _.each messages, (message) => @_addMessage message
    else
      @_addMessage messages

  createMessage: (body) ->
    @room.speak body

  getUser: (userId) ->
    _.findWhere @room.users, id: userId

  _get_current_messages: ->
    @room.messages (error, messages) => @addMessages messages

  _listen_for_new_messages: ->
    @room.listen (message) => @addMessages message

  _addMessage: (message) ->
    if message.userId == @room.campfire.user.id
      # Mark message as being by the current user
      message.bySelf = true

    @messages.push message
    @emit 'new_message', message
