url = require 'url'
Campfire = require('campfire').Campfire

CampfireView = require './campfire-view'

module.exports =
  campfireView: null

  activate: (state) ->
    atom.config.setDefaults 'campfire', token: '', account: '', room: ''

    @campfireView = new CampfireView

    @campfire = new Campfire
      token: atom.config.get 'campfire.token'
      account: atom.config.get 'campfire.account'

    @campfire.join atom.config.get('campfire.room'), (error, room) =>
      @campfireView.setRoom room

      room.messages (error, messages) =>
        @campfireView.addMessages messages

      room.listen (message) =>
        @campfireView.addMessages message

    atom.project.registerOpener (filePath) =>
      if filePath == 'campfire://room'
        @campfireView

    # atom.workspaceView.command 'campfire:show', =>
    atom.workspaceView.open 'campfire://room', split: 'left'

  deactivate: ->

  serialize: ->
