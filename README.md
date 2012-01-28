Getting Things Done with EngineYard AppCloud: Node.js Edition
=============================================================

Getting It
----------

This incarnation of the Todo app was built for [Node.js][] 0.6.8. If the Node
project has advanced to a degree that it no longer runs on the current version,
nave is listed as a development dependency so you can use it to drop down to a
working version of Node without affecting your global setup.

Otherwise, just clone it from GitHub!

`git clone git://github.com/nuclearsandwich/ey_todo-zappa.git`

And install the dependencies with [npm][]:

`npm install`

Running It
----------

After installing the dependencies, you can run the app with:

`node_modules/.bin/cake run`

Which will provide a local server for you to play with. To reload the code every
time you change the code, use `node_modules/.bin/cake rerun`

Testing It
----------

You can run the tests with `node_modules/.bin/cake test` or run them
continuously with `node_modules/.bin/cake rerun:test`

Deploying It
------------

Coming soon/


TODO
====

- Complete API endpoint implementation.

- Add in the Database layer

- Down the road:
  - Use Socket.IO/KnockoutJS for some of the frontend AJAX stuff since Zappa
    does Express and Socket.IO.

[Node.js]: http://nodejs.org
[npm]: http://npmjs.org
