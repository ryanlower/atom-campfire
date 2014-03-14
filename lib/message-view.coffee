autolinks = require 'autolinks'
emoji = require 'emoji-images'

{$, View} = require 'atom'

module.exports =
class MessageView extends View
  @content: ->
    @div class: 'message', =>
      @div outlet: 'body', class: 'body'

  initialize: (user, @message) ->
    @body.html @processed_body()

    if @message.type == 'PasteMessage'
      @body.addClass 'paste'
    if @message.mentionsSelf? && !@message.bySelf?
      @body.addClass 'mention'

  processed_body: ->
    @_autolinked @_emojified @message.body

  _emojified: (body) ->
    emoji body, 'atom://campfire/node_modules/emoji-images/pngs'

  _autolinked: (body) ->
    autolinks body
