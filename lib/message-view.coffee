{$,View} = require 'atom'

module.exports =
class MessageView extends View
  @content: ->
    @div class: 'message', =>
      @div outlet: 'user', class: 'user'
      @div outlet: 'timestamp', class: 'timestamp'
      @div outlet: 'body', class: 'body'

  initialize: (user, message) ->
    @user.html user.name
    @body.html message.body
