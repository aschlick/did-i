addLoadingClass = (ele) ->
  classes = ele.className
  ele.className = [classes, 'is-loading'].join(' ')

pageLoaded = (event) ->
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

      xhr.send()

document.addEventListener 'ready', pageLoaded
document.addEventListener 'turbolinks:load', pageLoaded

document.addEventListener 'turbolinks:click', (event) ->
  ele = event.target
  addLoadingClass ele
