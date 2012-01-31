module.exports = {
  # Tracker objects in order to mimic a functional database layer until later
  # in the development cycle.
  idCounter: 0
  allLists: []

  # Creates a list from the given object and saves it. Returns the id of the
  # list which can be used to get it back.
  createList: (list) ->
    list.id = @allLists.length
    @allLists.push list
    list.id

  # Updates a list with the given id with the property values of the given
  # object. Returns the object.
  updateList: (listId, properties) ->
    list = @get(listId)
    if list?
      list.name = properties.name
    list

  # Retrieve a List from the datastore by its id. Returns either a List object
  # or undefined if no list matches the id.
  get: (listId) ->
    @allLists[listId]

  nextId: ->
    idCounter += 1
}
