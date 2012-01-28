
vows = require 'vows'
assert = require 'assert'
List = require '../lib/list'

vows.describe('List').addBatch(
 'When we create a new list':
   topic: -> new List 'A test list'

   'Then its name is correct.': (list) -> assert.equal list.name, 'A test list'

 'With a task and a list':
   topic:
     list: new List 'A list with a task'
     task: 'Task'
   'When we add the task it is returned': ({task, list}) ->
     assert.isString list.addTask task

   'Then the tasks list includes the task': ({task, list}) ->
     assert.includes list.tasks, task
   'Then the task is returned': ({task, list}) ->
     assert.isString task
   'Then the length of tasks increases': ({list}) ->
       assert.equal list.tasks.length, 1

 'With a task already in a list.':
   topic: ->
     list = new List
     task = 'I should be removed'
     list.addTask task
     { list, task }

   'When we remove the task it is returned': ({task, list}) ->
     assert.isString list.removeTask task
   'Then the tasks list does not include the task': ({task, list}) ->
     assert.isTrue(list.tasks.indexOf(task) is -1)
   'Then the length of tasks decreases': ({task, list}) ->
     assert.equal list.tasks.length, 0

  'With a list, unfinished tasks, and completed tasks':
    topic: ->
      unfinishedTasks = [1..3].map ->
        { name: 'unfinished', isCompleted: -> false }
      completedTasks = [1..4].map ->
        { name: 'completed', isCompleted: -> true }
      list = new List 'A task list'
      unfinishedTasks.forEach (task) -> list.addTask task
      completedTasks.forEach (task) -> list.addTask task
      {unfinishedTasks, completedTasks, list}

    'When getting unfinishedTasks':
      topic: ({list, unfinishedTasks, completedTasks}) ->
        list.unfinishedTasks()

      'The list contains no completed tasks': (unfinishedTasks) ->
        assert.equal unfinishedTasks.length, 3
        assert.isFalse unfinishedTasks.some (task) -> task.isCompleted()

    'When getting completedTasks':
      topic: ({list, unfinishedTasks, completedTasks}) ->
        list.completedTasks()

      'The list contains only completed tasks': (completedTasks) ->
        assert.equal completedTasks.length, 4
        assert.isTrue completedTasks.every (task) -> task.isCompleted

).export module

