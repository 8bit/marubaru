# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

  jQuery ->
  	$('#thing_name').tokenInput '/things.json'
    	tokenLimit: 1
    	hintText: "What do you want to score? (ex: Fight Club, Ender's Game, Call of Duty: Black Ops II...)"
    	searchingText: 'Checking'
    	tokenValue: "name"