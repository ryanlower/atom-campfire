autolinks = require 'autolinks'
emoji = require 'emoji-images'

{$, View} = require 'atom'

module.exports =
class MessageView extends View
  @content: ->
    @div class: 'message'

  initialize: (user, @message) ->
    @html @processed_body()

    if @message.type == 'PasteMessage'
      @addClass 'paste'
    if @message.mentionsSelf? && !@message.bySelf?
      @addClass 'mention'

  processed_body: ->
    @_autolinked @_emojified @message.body

  _emojified: (body) ->
    emoji body, 'atom://campfire/node_modules/emoji-images/pngs'

  _autolinked: (body) ->
    autolinks body
