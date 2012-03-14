pg = require 'pg'

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

  @setDBConfig: (@dbConfig) ->
