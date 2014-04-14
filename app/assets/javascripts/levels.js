flashNotice = function(text){
  var container = $('div#flash div#notice');
  return container.html(text)
}

appendToOutput = function(text) {
  var container = $('div#output pre');
  return container.html(container.html()+text);
}

clearOutput = function(){
  $('div#output pre').html("");
  $('#messages-text').hide();
}

drawTable = function(tablearray) {
  var table = getHeader(tablearray[0]);
  table += getRows(tablearray);
  appendToOutput(table);
}

getHeader = function(row){
  var headerString = "", 
      len = "",
      i = 0;

  Object.keys(row).forEach(function (key) {
    headerString += padString(key.toString()) + " | ";
  });
  len = headerString.length
  
  headerString+="\n";
  for(i=0; i<len-1; i++){
    headerString+="‾";
  }
  headerString+="\n";
  return headerString;
}

getRows = function(tablearray){
  var rowString = "",
      row = {};
  for (row in tablearray) {
    Object.keys(tablearray[row]).forEach(function (key) {
      rowString += padString(tablearray[row][key].toString()) + " | ";
    });
    rowString += "\n";
  }
  return rowString;
}


padString = function(str){
  while (str.length < 15){
    str +=" ";
  }
  return str;
}

submitQuery = function(text) {
  $.post('/query', 
        {sql_command: text},
        updateView,
        "json"
    )
}

updateView = function(data){
  clearOutput();
  showMessages(data.response)
  if (data.response.display_type == "string"){
    appendToOutput(data.response.result)
  } else if (data.response.display_type == "table"){
    drawTable(data.response.result)
  }
  if (data.response.correct){
    correctAnswer()
  }
}

correctAnswer = function(){
  toggleModal("#next-level-modal");
}

toggleModal = function(selector){
  var $modal = $(selector);
  $modal.toggleClass("active");
  return $modal.on('click', function(){
   toggleModal(selector)
  })
}

showMessages = function(response){
  var message = ""
  if(response.correct){
    message = "Good job, you can go on now."
  }
  else if(response.errors.length > 0){
    for(err in response.errors){
      message+=response.errors[err]+"\n";
    }
  }
  if(message.length>0){
    var container = $('div#output pre');
    container.append($('<span class="message">'+message+'</span>'));
  }
}

$(document).ready(function() {

  $('#execute').on("click",function(){
      var text = $('#sql-command').val();
      return submitQuery(text);
    });

  $(document).keypress(13,function(e) {
  if(e.ctrlKey)
     $('#execute').click()
  });

  
})