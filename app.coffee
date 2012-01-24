zappa = require 'zappa'

zappa ->
  @set 'view engine': 'eco'
  @use 'bodyParser', 'methodOverride', @app.router, 'static'

  @configure
    development: =>
      @use errorHandler: { dumpExceptions: on }
    production: =>
      @use 'errorHandler'

  @get '/': ->
    lists = [
      {
        id: 1
        name: 'A first list'
        unfinishedTasks: -> []
        completedTasks: -> []
      },
      {
        id: 2
        name: 'List the second'
        unfinishedTasks: -> []
        completedTasks: -> []
      }]
    @render 'show_tasks': { lists }
