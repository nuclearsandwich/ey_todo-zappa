zappa = require 'zappa'

env = process.env.NODE_ENV || 'development'

pgClient = (require './db/client') env

List = require './lib/list'

List.pgClient = pgClient

zappa ->
  @set 'view engine': 'eco'
  @use 'bodyParser', 'methodOverride', @app.router, 'static'

  @configure
    development: =>
      @use errorHandler: { dumpExceptions: on }
    production: =>
      @use 'errorHandler'

  @get '/': ->
    @render 'show_tasks': { lists: listMapper.allLists }

  @get '/lists': ->

  @get '/lists/:listId': ->
    @render 'show_tasks':
      lists: listMapper.allLists
      selectedListId: @params.listId

  @post '/lists': ->
    listMapper.createList @body.list, (err, list) =>
      if err?
        throw err
      else
        @redirect "/lists/#{list.id}"

  @post '/lists/:listId': ->
    if @body._method is 'delete'
      listMapper.destroyList @params.listId, (err, list) =>
        if err?
          throw err
        else
          @redirect "/"

  @post '/lists/:listId/tasks': ->

