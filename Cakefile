{spawn, exec} = require 'child_process'
coffee_sources = [ 'app.coffee', 'lib/' ]

runCommand = (name, args...) ->
  proc = spawn name, args
  proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
  proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
  proc.on          'exit', (status) -> process.exit(1) if status isnt 0

task 'run', 'Run the Zappa app', ->
  runCommand 'node_modules/.bin/coffee', 'app.coffee'


