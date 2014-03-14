_ = require 'underscore-plus'
{$,View} = require 'atom'

MessageView = require './message-view'

module.exports =
class MessageGroupView extends View
  @content: ->
    @div class: 'message-group', =>
      @div outlet: 'user', class: 'user'
      @div outlet: 'body'

  initialize: (group) ->
    @user.html group.user.name

    @subscribe group, 'new_message', (message) =>
      message_view = new MessageView(group.user, message)
      message_view.appendTo @body
