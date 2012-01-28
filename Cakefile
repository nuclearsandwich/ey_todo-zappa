{spawn, exec} = require 'child_process'

system = (name, args...) ->
  proc = spawn name, args
  proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
  proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
  proc.on          'exit', (status) -> process.exit(1) if status isnt 0

testFiles =[ 'test/list-test.coffee', 'test/task-test.coffee' ]

rerunCommand = ['node_modules/.bin/runjs']
runCommand = [ 'node_modules/.bin/coffee', 'app.coffee' ]
testCommand = [ 'node_modules/.bin/vows', '--spec'].concat testFiles

task 'run', 'Run the Zappa app.', -> system runCommand...

task 'test', 'Run the Vows tests.', -> system testCommand...

task 'rerun:test', 'Run and rerun the Vows tests whenever files change.', ->
  system (rerunCommand.concat testCommand)...

task 'rerun', 'Run and rerun the Zappa app whenever files change.', ->
  system (rerunCommand.concat runCommand)...


