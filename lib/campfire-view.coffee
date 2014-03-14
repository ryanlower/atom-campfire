_ = require 'underscore-plus'
{$, View} = require 'atom'

MessageView = require './message-view'

module.exports =
class CampfireView extends View
  @content: ->
    @div class: 'campfire', =>
      @div outlet: 'room_info', class: 'overlay from-top'
      @div outlet: 'messages', class: 'messages padded block'
      @div class: 'new-message-container block', =>
        @input outlet: 'new_message', type: 'text'
        @button outlet: 'send_button', class: 'btn', 'Send'

  initialize: ->
    @send_button.on 'click', => @_sendMessage()

  setRoom: (room) ->
    @room = room
    @room_info.html @room.name

  addMessages: (messages) ->
    if _.isArray messages
      _.each messages, (message) => @_addMessage message
    else
      @_addMessage messages

  _addMessage: (message) ->
    # Only show text messages for now
    if message.type == 'TextMessage'
      user = @_getUser message.userId
      message_view = new MessageView(user, message)
      message_view.appendTo @messages

  _getUser: (userId) ->
    _.findWhere @room.users, id: userId

  _sendMessage: ->
    msg = @new_message.val()
    @new_message.val ''
    @room.speak msg
