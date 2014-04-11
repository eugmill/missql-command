$(document).ready(function() {

flashNotice = function(text){
	var container = $('div#flash div#notice');
	return container.html(text)
}

appendToOutput = function(text) {
  var container = $('div#output pre');
  return container.html(text);
}

})