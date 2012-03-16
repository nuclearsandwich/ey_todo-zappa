pg = require 'pg'
Task = require './task'

module.exports = class List
  constructor: (@name) ->
    @tasks = []
    @client = new pg.Client List.dbConfig
    @client.on 'drain', @client.end.bind @client
    @client.connect()
    @_saved = false

  addTask: (task) ->
    @tasks.push task
    @_saved = false
    task

  removeTask: (task) ->
    @tasks = @tasks.filter (t) -> t != task
    @_saved = false
    task

  unfinishedTasks: -> @tasks.filter (task) -> not task.isCompleted()

  completedTasks: -> @tasks.filter (task) -> task.isCompleted()

  isSaved: -> @_saved

  save: (callback) ->
    self = this

    @client.query {
      name: 'insert'
      values: [@name]
      text: 'INSERT INTO lists(name) VALUES ($1) RETURNING id;'
    }, (err, result) ->
      callback err, null if err?
      self.id = result.rows[0].id
      self._saved = true
      if self.tasks.length is 0
        callback null, self
      else
        savedTaskCount = 0
        self.tasks.forEach (t) ->
          t.save (err, task) ->
            savedTaskCount += 1
            task.listId = self.id
            if savedTaskCount is self.tasks.length
              callback null, self
    return

  destroy: (callback) ->
    self = this
    @client.query {
      name: 'delete-list'
      text: 'DELETE FROM lists WHERE id = $1;'
      values: [@id]
    }, (err, result) ->
      if err?
        callback err, null
        return
      console.log "returning from destroy with", self
      callback null, self
    return


  @get: (listId, callback) ->
    client = new pg.Client @dbConfig
    client.on 'drain', client.end.bind client
    client.connect()
    client.query {
      name: 'select-by-id'
      text: 'SELECT * FROM lists WHERE id = $1 LIMIT 1;'
      values: [listId]
    }, (err, result) ->
      if err?
        callback err, null
        return
      if result.rows.length is 0
        callback null, null
        return
      listRow = result.rows[0]
      list = new List listRow.name
      list.id = listRow.id
      client.query {
        name: 'select-tasks-by-list-id'
        text: 'SELECT * FROM tasks WHERE list_id = $1;'
        values: [listId]
      }, (err, result) ->
        callback err, null if err?
        result.rows.forEach (taskRow) ->
          task = {}
          task.name = taskRow.name
          task.completed = taskRow.completed
          task.listId = taskRow.list_id
          list.addTask task
        callback null, list

  @setDBConfig: (@dbConfig) ->
