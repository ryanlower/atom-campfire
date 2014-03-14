_ = require 'underscore-plus'
{$,View} = require 'atom'

MessageView = require './message-view'

module.exports =
class MessageGroupView extends View
  @content: ->
    @div class: 'message-group', =>
      @div outlet: 'timestamp', class: 'timestamp'
      @div outlet: 'user', class: 'user'
      @div outlet: 'body'

  initialize: (@group) ->
    @user.html @group.user.name
    @timestamp.html @group.firstMessage().createdAt
    @_addMessage @group.firstMessage()

    @subscribe @group, 'new_message', (message) =>
      @_addMessage message

  _addMessage: (message) ->
    message_view = new MessageView(@group.user, message)
    message_view.appendTo @body
