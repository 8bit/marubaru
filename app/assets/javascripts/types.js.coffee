# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#jQuery ->
#  $('#').chosen({no_results_text: '<a style="color:lightBlue;", href="/types/new">You can be the first to review a </a>'});

  jQuery ->
  	$('#type_name').tokenInput '/types.json'
    	tokenLimit: 1
    	hintText: "What type of thing do you want to rate? (ex: movie, book, game...)"
    	searchingText: 'Checking'
    	tokenValue: "name"