
# Require the list constructor object
List = require '../lib/list'

module.exports = listMapper = {
  # Tracker objects in order to mimic a functional database layer until later
  # in the development cycle.
  idCounter: 0
  allLists: []

  # Creates a list from the properties of the given object and saves it.
  # The callback function is called with the error value, if any, and the
  # created list.
  createList: (listProperties, callback) ->
    list = new List listProperties.name
    list.id = @allLists.length
    @allLists.push list
    callback null, list

  # Updates a list with the given id with the property values of the given
  # object. Returns the object.
  updateList: (listId, listProperties, callback) ->
    @getList listId, (err, list) ->
      if err?
        callback err
      else
        list.name = listProperties.name
        callback null, list

  # Remove the list with specified id from the datastore, return the deleted
  # list in a callback function.
  destroyList: (listId, callback) ->
    list = @allLists.filter((list) -> list.id is listId)[0]
    if list?
      @allLists = @allLists.filter (list) -> list.id isnt listId
      callback null, list
    else
      callback new Error "List with id: #{listId} not found."


  # Retrieve a List from the datastore by its id. Returns either a List object
  # or undefined if no list matches the id.
  getList: (listId, callback) ->
    callback null, @allLists[listId]

  nextId: -> idCounter += 1
}
