# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(->
  $(document).on('click','#shorten',(e)->
    if $('#link_long_link').val().length == 0
      e.preventDefault()
      $('#link_long_link').attr('placeholder','Please provide link')
      $('#link_long_link').addClass('warning')
  )
)