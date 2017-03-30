# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.add_child').click ->
    association = $(this).attr('data-association')
    target = $(this).attr('target')
    regexp = new RegExp('new_' + association, 'g')
    new_id = (new Date).getTime()
    ing = if target == '' then $(this).parent() else $('#' + target)
    ing.append window[association + '_fields'].replace(regexp, new_id)
    false

  $(document).delegate '.remove_child', 'click', ->
    $(this).parent().children('.removable')[0].value = 1
    $(this).parent().hide()
    false
