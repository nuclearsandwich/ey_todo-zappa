
require 'js-yaml'

pg = require 'pg'

# Shift it in order to get the first document as js-yaml prepares for multiple
# documents per file.
dbConfig = (require '../config/database.yml').shift()

module.exports = (env) -> new pg.Client dbConfig[env]
