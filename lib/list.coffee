module.exports = class List
  constructor: (@name) -> @tasks = []

  addTask: (task) ->
    @tasks.push task
    task

  removeTask: (task) ->
    @tasks = @tasks.filter (t) -> t != task
    task

  unfinishedTasks: -> @tasks.filter (task) -> not task.isCompleted()

  completedTasks: -> @tasks.filter (task) -> task.isCompleted()

