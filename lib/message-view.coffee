{$, View} = require 'atom'

module.exports =
class MessageView extends View
  @content: ->
    @div class: 'message', =>
      @div outlet: 'body', class: 'body'

  initialize: (user, message) ->
    @body.html message.body
    if message.type == 'PasteMessage'
      @body.addClass 'paste'
