module.exports = class List
  constructor: (@name) -> @tasks = []

  addTask: (task) ->
    @tasks.push task
    task

  removeTask: (task) ->
    @tasks = @tasks.filter (t) -> t != task
    task

