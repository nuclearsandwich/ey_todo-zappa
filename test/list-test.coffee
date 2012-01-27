
vows = require 'vows'
assert = require 'assert'
List = require '../lib/list'

vows.describe('A list exists').addBatch(
 'When we create a new list':
   topic: -> new List 'A test list'
   'Then its name is correct.': (list) -> assert.equal list.name, 'A test list'
   'When a task is added':
     topic: (list) ->
       task: list.addTask 'Task'
       list: list
     'Then the task is returned': ({task, list}) -> assert.isString task
   'Then the length of tasks increases': (list) ->
       assert.equal list.tasks.length, 1
   'When a task is removed':
     topic: (list) ->
       task: list.removeTask 'Task'
       list: list
     'Then the task is returned': ({task, list}) -> assert.isString task
   'Then the length of tasks decreases': (list) ->
     assert.equal list.tasks.length, 0
).export module

