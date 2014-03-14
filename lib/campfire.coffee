url = require 'url'
Campfire = require('campfire').Campfire

CampfireView = require './campfire-view'
Room = require './room'

module.exports =
  campfireView: null

  activate: (state) ->
    atom.config.setDefaults 'campfire', token: '', account: '', room: ''

    @campfireView = new CampfireView

    @campfire = new Campfire
      token: atom.config.get 'campfire.token'
      account: atom.config.get 'campfire.account'

    @campfire.me (error, me) =>
      @campfire.user = me.user

    @campfire.join atom.config.get('campfire.room'), (error, room) =>
      @room = new Room(room)
      @campfireView.setRoom @room

    atom.project.registerOpener (filePath) =>
      if filePath == 'campfire://room'
        @campfireView

    # atom.workspaceView.command 'campfire:show', =>
    atom.workspaceView.open 'campfire://room', split: 'left'

  deactivate: ->

  serialize: ->
