pg = require 'pg'

client = new pg.Client {
  user: 'steven'
  database: 'todonode'
  password: null
  port: 5432
  host: 'localhost'
}

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

createListTable = (client) ->
  client.query createListString, (err, result) ->
    if err?
      console.log err
    else
      console.log result

createTaskTable = (client) ->
  client.query createTaskString, (err, result) ->
    if err?
      console.log err
    else
      console.log result

createAllTheTables = (client) ->
  createListTable client
  createTaskTable client

module.exports = { client, createAllTheTables, createListTable, createTaskTable }

