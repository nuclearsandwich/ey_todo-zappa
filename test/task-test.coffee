
vows = require 'vows'
assert = require 'assert'
Task = require '../lib/task'

vows.describe('Task').addBatch(
 'When we create a new task':
   topic: new Task 'A task'

   'Then its name is correct': (task) ->
     assert.equal task.name, 'A task'
   'Then it is unfinished by default': (task) ->
     assert.isFalse task.isCompleted()

 'Marking a task complete':
   topic: new Task 'A task'

   'It should change the value of isCompleted() to true': (task) ->
     assert.isFalse task.isCompleted()
     task.markCompleted()
     assert.isTrue task.isCompleted()

 'Marking a task unfinished':
   topic: ->
     task = new Task 'A task'
     task.markCompleted()
     task

   'It should change the value of isCompleted() to false': (task) ->
     assert.isTrue task.isCompleted()
     task.markUnfinished()

     assert.isFalse task.isCompleted()
).export module
