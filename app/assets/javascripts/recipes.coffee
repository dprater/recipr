ready = ->
  $('.add_child').click ->
    association = $(this).attr('data-association')
    target = $(this).attr('target')
    regexp = new RegExp('new_' + association, 'g')
    new_id = (new Date).getTime()
    update_div = if target == '' then $(this).parent() else $('#' + target)
    update_div.append window[association + '_fields'].replace(regexp, new_id)
    false

  $(document).delegate '.remove_child', 'click', ->
    $(this).parent().children('.removable')[0].value = 1
    $(this).parent().hide()
    false

$(document).ready(ready)
$(document).on('page:load', ready)
