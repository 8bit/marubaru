# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#type_name').chosen({no_results_text: '<a style="color:lightBlue;", href="/types/new">You can be the first to review a </a>'});