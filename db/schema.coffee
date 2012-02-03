callback = (err, result) ->
  if err?
    console.log "ERROR: #{err}"
  else
    console.log "SUCCESS: #{result}"

createListString = """
  CREATE TABLE lists (
    id SERIAL PRIMARY KEY,
    name varchar(255)
  );
  """

createTaskString = """
  CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    name varchar(255),
    list_id integer REFERENCES lists(id),
    completed_at date
  );
  """

dropListTable = (client) ->
  client.query "DROP TABLE lists;", callback

dropTaskTable = (client) ->
  client.query "DROP TABLE tasks;", callback


createListTable = (client) ->
  client.query createListString, callback

createTaskTable = (client) ->
  client.query createTaskString, callback

createAllTheTables = (client) ->
  createListTable client
  createTaskTable client

destructivelyAndNaivelyDropAndRecreateDatabaseTables = (client) ->
  dropTaskTable client
  dropListTable client
  createListTable client
  createTaskTable client
  client.on 'drain', client.end.bind client
  client.connect()

module.exports = {destructivelyAndNaivelyDropAndRecreateDatabaseTables}


