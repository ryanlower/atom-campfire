emoji = require 'emoji-images'

{$, View} = require 'atom'

module.exports =
class MessageView extends View
  @content: ->
    @div class: 'message', =>
      @div outlet: 'body', class: 'body'

  initialize: (user, @message) ->
    @body.html @emojified_body()

    if @message.type == 'PasteMessage'
      @body.addClass 'paste'
    if @message.mentionsSelf? && !@message.bySelf?
      @body.addClass 'mention'

  emojified_body: ->
    emoji @message.body, 'atom://campfire/node_modules/emoji-images/pngs'
