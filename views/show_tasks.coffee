doctype 5
html ->
  head ->
    title 'Getting Things Done with EngineYard\'s AppCloud'
    link rel: 'stylesheet', href: '/stylesheets/core.css'
    link rel: 'stylesheet', href: '/stylesheets/jq-tabs.css'
  body ->
    div '#tabs', ->
      ul ->
        for list in []
          li ->
            a href: "#tabs-3", 'A sample task'
        li ->
          a href: "#tabs-new-list", 'Add List +'
      for list in []
        div "#tabs-#{list.id}.tab", ->
          div '.new-task', ->
            form action: "/lists/#{list.id}/tasks", method: 'post', name: 'new_task', ->
              input size: 50, required: "required", type: 'text', name: 'task[name]', value: '', label: 'false', placeholder: 'Enter a new task'
        div '#button', ->
          input type: 'submit', name: 'Add Task', value: 'submit'
      div "#tabs-new-list", ->
