
require 'js-yaml'

# Shift it in order to get the first document as js-yaml prepares for multiple
# documents per file.
dbConfig = (require './database.yml').shift()
module.exports = dbConfig[process.env.NODE_ENV || 'development']

