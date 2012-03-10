pg = require 'pg'

module.exports = class List
  constructor: (@name) ->
    @pgClient = List.pgClient
    @dirty = true
    @tasks = []

  addTask: (task) ->
    @tasks.push task
    task

  removeTask: (task) ->
    @tasks = @tasks.filter (t) -> t != task
    task

  unfinishedTasks: -> @tasks.filter (task) -> not task.isCompleted()

  completedTasks: -> @tasks.filter (task) -> task.isCompleted()

  save: (callback) ->
    callback null, this

  destroy: (callback) ->
    callback null, this

  # Methods on the class / constructor function.
  @all: (callback) ->
    callback null, @allLists

  @get: (listId, callback) ->
    console.log "getting list #{listId}"
    callback null, @allLists[listId]
