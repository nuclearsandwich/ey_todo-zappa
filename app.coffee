zappa = require 'zappa'

zappa ->
  @enable 'default layout', 'serve jquery', 'serve sammy', 'minify'

  @use 'bodyParser', 'methodOverride', @app.router, 'static'

  @configure
    development: =>
      @use errorHandler: { dumpExceptions: on }
    production: =>
      @use 'errorHandler'

  @get '/': ->
    @lists = []
    @render 'show_tasks'
