// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require_tree .

$(function() {
	$('#recipe_search').autocomplete({
	  source: function(request, response) {
	    $.get('/recipes/search.json', {
	      query: request.term
	    }, function(data) {
	      response(data);
	    });
	  },
	  minLength: 2,
    select: function(event, ui) {
              $('#recipe_search').val(ui.item.label);
              $('#recipe_search_value').val(ui.item.val);
            }
	});

  $('#search_form').submit(function() {
    return false;
  });

  $('#recipe_selector').click(function() {
      id = $('#recipe_search_value').val();
      window.location.href = 'http://localhost:3000/recipes/' + id;
  });
    
});
