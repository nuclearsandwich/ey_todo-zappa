module.exports = class Task
  constructor: (@name) -> @completed = false

  isCompleted: -> @completed

  markCompleted: -> @completed = true

  markUnfinished: -> @completed = false

