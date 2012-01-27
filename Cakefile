{spawn, exec} = require 'child_process'

runCommand = (name, args...) ->
  proc = spawn name, args
  proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
  proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
  proc.on          'exit', (status) -> process.exit(1) if status isnt 0

task 'run', 'Run the Zappa app.', ->
  runCommand 'node_modules/.bin/coffee', 'app.coffee'

task 'test', 'Run the Vows tests.', ->
  runCommand 'node_modules/.bin/coffee', 'test'

task 'test', 'Run and rerun the Vows tests whenever files change.', ->
  runCommand 'node_modules/.bin/runjs', 'node_modules/.bin/coffee', 'test'

task 'rerun', 'Run and rerun the Zappa app whenever files change.', ->
  runCommand 'node_modules/.bin/runjs', 'node_modules/.bin/coffee', 'app.coffee'


