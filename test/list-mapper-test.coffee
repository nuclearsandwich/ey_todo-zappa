
vows = require 'vows'
assert = require 'assert'
listMapper = require '../lib/list-mapper'
List = require '../lib/list'

vows.describe('ListMapper').addBatch(
 'Given a list is created':
   topic: ->
     listId = listMapper.createList name: 'Wicked sick'
     {listMapper, listId}

   'then that list should be in the database': ({listMapper, listId}) ->
     assert.isNotNull listMapper.get listId

   'when another list is created':
     topic: ({listMapper, listId}) ->
       listMapper.createList name: 'Another list'
       {listMapper, listId}
     'then the original is still accessible': ({listMapper, listId}) ->
       assert.equal listMapper.get(listId).name, 'Wicked sick'

   'when the list is updated':
     topic: ({listMapper, listId}) ->
       listMapper.updateList listId, name: 'Super slick'

).export module

