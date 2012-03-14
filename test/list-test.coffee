
vows = require 'vows'
assert = require 'assert'
dbConfig = require '../config/database'
List = require '../lib/list'
List.setDBConfig dbConfig

vows.describe('List').addBatch(
  'When a new list is created':
    topic: new List 'A test list'
    'Then its name is correct.': (list) -> assert.equal list.name, 'A test list'
    'Then it is not yet saved.': (list) ->
      assert.isFalse list.isSaved()
      assert.isUndefined list.id

  'When a list is added to a task':
    topic: ->
      list = new List 'A list with a task'
      task = 'Task'
      list.addTask task
      { list, task }

    'Then the task is returned': ->
      list = new List 'A list'
      task = 'A Task'
      assert.equal task, list.addTask task
    'Then the list becomes unsaved': ->
      list = new List 'A saved list'
      list._saved = true
      list.addTask 'some task'
      assert.isFalse list.isSaved()
    'Then the tasks list includes the task': ({task, list}) ->
      assert.includes list.tasks, task
    'Then the length of tasks increases': ({list}) ->
      assert.equal list.tasks.length, 1
    'Then the length of tasks increases': ({list}) ->
      assert.equal list.tasks.length, 1

  'When a removing a task':
    topic: ->
      list = new List 'task with a list'
      task = 'I should be removed'
      list.addTask task
      list.removeTask task
      { list, task }

    'Then the task is returned': ->
      list = new List 'A list'
      task = 'A Task'
      list.addTask task
      assert.equal task, list.removeTask task
    'Then the list becomes unsaved': ->
      list = new List 'A saved list'
      list.addTask 'some task'
      list._saved = true
      list.removeTask 'some task'
      assert.isFalse list.isSaved()
    'Then the tasks list does not include the task': ({task, list}) ->
      assert.isTrue(list.tasks.indexOf(task) is -1)
    'Then the length of tasks decreases': ({task, list}) ->
      assert.equal list.tasks.length, 0

  'When adding a list, unfinished tasks, and completed tasks':
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
      'Then the list contains no completed tasks': (unfinishedTasks) ->
        assert.equal unfinishedTasks.length, 3
        assert.isFalse unfinishedTasks.some (task) -> task.isCompleted()

    'When getting completedTasks':
      topic: ({list, unfinishedTasks, completedTasks}) ->
        list.completedTasks()
      'Then the list contains only completed tasks': (completedTasks) ->
        assert.equal completedTasks.length, 4
        assert.isTrue completedTasks.every (task) -> task.isCompleted

  'When a list is saved':
    topic: ->
      list = new List 'A persisted list'
      list.save @callback
    'Then there is no error': (err, list) ->
      assert.isNull err
    'Then the list has an id': (err, list) ->
      assert.isNumber list.id
    'Then the list is saved': (err, list) ->
      assert.isTrue list.isSaved()
    'When the list has tasks':
      topic: ->
        task = {
          name: 'A difficult task'
          _saved: false
          isSaved: -> @_saved
          save: (callback) ->
            @_saved = true
            callback null, this
        }
        list = new List "A pretty cool list"
        list.addTask task
        list.save @callback
      'Then the tasks are saved and have the proper listId': (err, list) ->
        assert.isNull err
        assert.isTrue list.tasks[0].isSaved()
        assert.equal list.tasks[0].listId, list.id

).export module

