{$, View} = require 'atom'

MessageGroup = require './message-group'
MessageGroupView = require './message-group-view'

module.exports =
class RoomView extends View
  @content: ->
    @div class: 'room', =>
      @div outlet: 'room_info', class: 'overlay from-top'
      @div outlet: 'messages', class: 'messages block'
      @div class: 'new-message-container', =>
        @input outlet: 'new_message', type: 'text', class: 'native-key-bindings'

  initialize: (@room) ->
    # Listen for new message events on the Room
    @subscribe @room, 'new_message', (message) =>
      @_addMessage message
      @_scrollToLatestMessage()

    # Listen for enter in new message input
    @new_message.on 'keydown', (e) =>
      if e.keyCode == 13 && @new_message.val()
        @_sendMessage()

    @room_info.html @room.room.name

  _addMessage: (message) ->
    # Only show text and paste messages for now
    if message.type == 'TextMessage' or message.type == 'PasteMessage'
      user = @room.getUser message.userId

      if @lastGroup?.addMessageToGroup message
        # The last message was by the same user
        # So add this message to the previous group
        group = @lastGroup
        group.addMessage message
      else
        # New user, so new message group
        group = new MessageGroup(user, message)
        group_view = new MessageGroupView(group)
        group_view.appendTo @messages

      # Remember this group for the next message
      @lastGroup = group

  _scrollToLatestMessage: ->
    @messages.scrollTop @messages.prop('scrollHeight')

  _sendMessage: ->
    msg = @new_message.val()
    @new_message.val ''
    @room.createMessage msg
