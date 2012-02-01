
vows = require 'vows'
assert = require 'assert'
listMapper = require '../lib/list-mapper'

vows.describe('ListMapper').addBatch(
  'Given a list is created':
    topic: ->
      listMapper.createList name: 'Wicked sick', @callback
      return

    'then a list should be created without error': (err, list) ->
      assert.isNull err
      assert.isNotNull list

    'then the callback list should be get-able by its id ': (err, list) ->
      listMapper.get list.id, (err, fetchedList) =>
        assert.equal list.id, fetchedList.id
        assert.equal list.name, fetchedList.name

  'Given a list that is then updated':
    topic: ->
      listMapper.createList name: 'crapy misspelt liss', (err, list) =>
        listMapper.updateList list.id, name: 'A better list name', @callback
      return

    'then there should be no error': (err, list) ->
      assert.isNull err
    'then the list properties should be updated': (err, list) ->
      assert.equal list.name, 'A better list name'

).export module

