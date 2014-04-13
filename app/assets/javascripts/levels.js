flashNotice = function(text){
  var container = $('div#flash div#notice');
  return container.html(text)
}

appendToOutput = function(text) {
  var container = $('div#output pre');
  return container.html(text);
}

drawTable = function(array) {
  appendToOutput(array.toString());
  // array.each(function(el){
  //   appendToOutput(el);
  // })
}

submitQuery = function(text) {
  $.post('/query', 
        {sql_command: text},
        updateView,
        "json"
    )
}

updateView = function(data){
  if (data.response.display_type == "string"){
    appendToOutput(data.response.result)
  } else if (data.response.display_type == "table"){
    drawTable(data.response.result)
  }
  console.log(data);
}

$(document).ready(function() {

  $('#execute').on("click",function(){
      var text = $('#sql-command').val();
      return submitQuery(text);
    }

    )

})