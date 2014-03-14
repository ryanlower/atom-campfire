{$, View} = require 'atom'

RoomView = require './room-view'

module.exports =
class CampfireView extends View
  @content: ->
    @div class: 'campfire', =>
      @div outlet: 'room_container'

  setRoom: (@room) ->
    @room_view = new RoomView(@room)
    @room_view.appendTo @room_container
