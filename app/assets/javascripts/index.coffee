addLoadingClass = (ele) ->
  classes = ele.className
  ele.className = [classes, 'is-loading'].join(' ')

removeLoadingClass = (ele) ->
  classes = ele.className
  classes = classes.split ' '
  ind = classes.indexOf 'is-loading'
  if ind > -1
    classes.splice ind, 1
    ele.className = classes.join ' '

handleAlertCleared = ->
  Array.from document.getElementsByClassName 'notification'
  .forEach (e) ->
    Array.from e.getElementsByClassName 'delete'
    .forEach (btn) ->
      btn.addEventListener 'click', (event) ->
        e.remove()

pageLoaded = (event) ->
  handleAlertCleared()

  Array.from document.getElementsByClassName 'is-loading'
  .forEach (e) ->
    removeLoadingClass e

  Array.from document.getElementsByClassName 'replace-item'
  .forEach (e) ->
    e.addEventListener 'click', (event) ->
      ele = event.target
      id = ele.dataset.id
      addLoadingClass ele

      token = document.getElementsByName('csrf-token')[0].content
      xhr = new XMLHttpRequest()

      xhr.open 'POST', "items/#{id}/replacements", true
      xhr.setRequestHeader 'X-CSRF-Token', token

      xhr.onreadystatechange = () ->
        if xhr.readState == XMLHttpRequest.Done
          if xhr.status == 200
            Turbolinks.clearCache()
            Turbolinks.visit '/items'
        removeLoadingClass ele

      xhr.send()

document.addEventListener 'ready', pageLoaded
document.addEventListener 'turbolinks:load', pageLoaded

document.addEventListener 'turbolinks:click', (event) ->
  ele = event.target
  addLoadingClass ele
