flashNotice = function(text){
  var container = $('div#flash div#notice');
  return container.html(text)
}

appendToOutput = function(text) {
  var container = $('div#output pre');
  return container.html(text);
}

submitQuery = function(text) {
  $.post('/query', 
        {sql_command: text},
        updateView,
        "json"
    )
}

updateView = function(data){
  alert(data);
  console.log(data);
}

$(document).ready(function() {

  $('#execute').on("click",function(){
      var text = $('#sql-command').val();
      return submitQuery(text);
    }

    )

})