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
  var headerString = "\n", 
      len = "",
      i = 0;
      padding = 15;
  Object.keys(row).forEach(function (key) {
    padding = 15;
    if(key.toString()=="id"){
      padding = 5;
    }
    headerString += padString(key.toString(), padding) + " | ";
  });
  len = headerString.length
  
  headerString+="\n";
  for(i=0; i<len-2; i++){
    headerString+="‾";
  }
  headerString+="\n";
  return headerString;
}

getRows = function(tablearray){
  var rowString = "",
      row = {}, 
      padding = 15;
  for (row in tablearray) {
    Object.keys(tablearray[row]).forEach(function (key) {
    padding = 15
    if(key.toString()=="id"){
      padding = 5;
    }
      rowString += padString(tablearray[row][key].toString(), padding) + " | ";
    });
    rowString += "\n";
  }
  return rowString;
}


padString = function(str, length){
  var len = (length) ? length : 15;
  while (str.length < len){
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
  if(!response.correct){
    if(response.errors.length > 0){
      for(err in response.errors){
        message+=response.errors[err]+"\n";
      }
    }
  } 
  if(message.length>0){
    var container = $('div#output pre');
    container.append($('<span class="message">'+message+'</span>\n'));
  }
}

swapPage = function($arrowEl){
  var curPage = $("article.level-page.active"),
      count = $("article.level-page").length,
      curNum = curPage.data('page-number'),
      nextNum = 0,
      nextPage = {};
  if($arrowEl.hasClass('left')){
    nextNum = (curNum - 1 < 0) ? count - 1 : curNum - 1;
  } else{
    nextNum = (curNum + 1 > count - 1) ? 0 : curNum + 1;
  }
    nextPage = $("article.level-page[data-page-number='"+ nextNum +"']");
    curPage.toggleClass("active"); 
    nextPage.toggleClass("active");
    return updatePageNumber(nextNum + 1)
}
updatePageNumber = function(number){
  var pagenumber = $("span#page-number");
  pagenumber.html(number);
  return $('#pages-nav').one("click", function(e){
    e.preventDefault();
    clearSelection();
    var target = $(e.target);
    if (target.hasClass('arrow')){
    return swapPage(target);
    }
  });
}
clearSelection = function(){
  if (window.getSelection) {
  if (window.getSelection().empty) {  // Chrome
    window.getSelection().empty();
  } else if (window.getSelection().removeAllRanges) {  // Firefox
    window.getSelection().removeAllRanges();
  }
} else if (document.selection) {  // IE?
  document.selection.empty();
}
}


$(document).ready(function() {
  $('#execute').on("click",function(){
      var text = $('#sql-command').val();
      return submitQuery(text);
    });

  $('#pages-nav').one("click", function(e){
    e.preventDefault();
    clearSelection();
    var target = $(e.target);
    if (target.hasClass('arrow')){
    return swapPage(target);
    }
  });

  $('li.tab').on("click", function(e){
    var $target = $(this);
    console.log($target.attr("class"));
    if($target.hasClass('active')){
      return $target.removeClass('active')
    } else{
      $("li.tab.active").removeClass('active')
      return $target.addClass('active')
    }
  });

  $(document).keypress(13,function(e) {
  if(e.ctrlKey){
      e.preventDefault();
     $('#execute').click()
   }
  });

  
})