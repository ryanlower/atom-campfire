{$, View} = require 'atom'

MessageGroup = require './message-group'
MessageGroupView = require './message-group-view'

module.exports =
class RoomView extends View
  @content: ->
    @div class: 'room', =>
      @div outlet: 'room_info', class: 'overlay from-top'
      @div outlet: 'messages', class: 'messages block'
      @div class: 'new-message-container block', =>
        @input outlet: 'new_message', type: 'text'
        @button outlet: 'send_button', class: 'btn', 'Send'

  initialize: (@room) ->
    @subscribe @room, 'new_message', (message) =>
      @_addMessage message
      @_scrollToLatestMessage()
    @send_button.on 'click', => @_sendMessage()
    @room_info.html @room.name

  _addMessage: (message) ->
    # Only show text and paste messages for now
    if message.type == 'TextMessage' or message.type == 'PasteMessage'
      user = @room.getUser message.userId

      group = new MessageGroup(user)
      group.addMessage message

      group_view = new MessageGroupView(group)
      group_view.appendTo @messages

  _scrollToLatestMessage: ->
    @messages.scrollTop @messages.prop('scrollHeight')

  _sendMessage: ->
    msg = @new_message.val()
    @new_message.val ''
    @room.createMessage msg
