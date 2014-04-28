//takes a string of text and submits it via post to the query route
submitQuery = function(text) {

 $.post('/query', 
        {sql_command: text},
        updateView,
        "json"
    )

}

//receives the returned data from submitQuery and adds it to the REPL
updateView = function(data){
  //clears the output pane
  clearOutput();

  //does a quick syntax check on the query to alert users to single quote requirement
  if(!data.response.correct && data.query.match(/"/g)){
    
    data.response.errors.push("Make sure you're using single quotes for your strings.\n");
  
  }

  //passes the response attribute of the data to showMessages to display errors and hints
  showMessages(data.response);

  //checks display type property and sends output to the appropriate rendering function
  if (data.response.display_type == "string"){

    appendToOutput(data.response.result);

  } else if (data.response.display_type == "table"){

    drawTable(data.response.result);

  }
  //checks for correctness of response object
  if (data.response.correct){

    correctAnswer();

  }

}

//clears the ouput pane of the repl
clearOutput = function(){
  
  $('div#output pre').html("");

}

//appends text to the output pane
appendToOutput = function(text) {

  var container = $('div#output pre');
  
  container.html(container.html()+text);
}

//formats an array of hashes of postgres tuples into a table structure for appending
drawTable = function(tablearray) {
  var table = getHeader(tablearray[0]);

  table += getRows(tablearray);

  appendToOutput(table);
}

//takes in a single row of tuples in hash format and creates a header string for a table
getHeader = function(row){

  var headerString = "\n",
      padding = 15,
      keyString;

  Object.keys(row).forEach(function (key) {
    
    keyString = key.toString();
    padding = 15;

    //checks if the current column is a primary or foreign key and shortens its padding to save space
    if(keyString.match(/id$/i)){
      padding = (keyString.length > 5) ? keyString.length : 5;
    }

    //passes the string to helper to add spaces and adds it to the headerString
    headerString += padString(key.toString(), padding) + " | ";

  });

  headerString += underlineString(headerString.length);

  return headerString;
}

//takes in the length of a string and spits out a string of overscores and new lines to create an
//underline string
function underlineString(length){

  var overScores = "\n",
      i=0;

  for(i; i<length-2; i++){
    overScores += "‾";
  }

  overScores += "\n";

  return overScores;
}

//takes in an array of hashes  and ouputs a string of table columns
getRows = function(tablearray){

  var rowString = "",
      row = {}, 
      padding = 15;

  for (row in tablearray) {

    Object.keys(tablearray[row]).forEach(function (key) {

      keyString = key.toString();
      
      padding = 15;

      if(keyString.match(/id$/i)){
        padding = (keyString.length > 5) ? keyString.length : 5;
      }
      
      rowString += padString(tablearray[row][key].toString(), padding) + " | ";
    
    });

    rowString += "\n";
  }

  return rowString;
}

//takes a string and a target length and adds spaces until that length is reached
padString = function(str, length){

  var len = (length) ? length : 15;

  while (str.length < len){

    str +=" ";

  }

  return str;
}

//calls teh toggleModal function on a correct answer
correctAnswer = function(){
  toggleModal("#next-level-modal");
}

//toggless on the modal on a correct answer
toggleModal = function(selector){

  var $modal = $(selector);

  if(!$modal.hasClass("active")){

    $modal.toggleClass("active");

  return $modal.on('click', function(){
    $modal.removeClass("active");

  });

  }
}

//displays message boxes for errors and hints
showMessages = function(response){

  var container = $("div#output pre");

  if(!response.correct){

    if(response.errors.length > 0){

      for(err in response.errors){

        container.append($('<span class="message">'+response.errors[err]+'</span>\n'));

      }

    }

  }

}


//takes in a jQuery selected arrow button from the levelpages pane and swaps the current page for the next one
swapPage = function($arrowEl){

  var curPage = $("article.level-page.active"),
      count = $("article.level-page").length,
      curNum = curPage.data('page-number'),
      nextNum = 0,
      nextPage = {};

  //does checking logic to allow the pages to cycle
  if($arrowEl.hasClass('left')){

    nextNum = (curNum - 1 < 0) ? count - 1 : curNum - 1;

  } else{

    nextNum = (curNum + 1 > count - 1) ? 0 : curNum + 1;

  }

    nextPage = $("article.level-page[data-page-number='"+ nextNum +"']");
  
    curPage.toggleClass("active"); 
    nextPage.toggleClass("active");
  
    updatePageNumber(nextNum + 1);
  
    return pageScrollCheck();
}

//updates the current page unumber
updatePageNumber = function(number){
  var pagenumber = $("span#page-number");
  return pagenumber.html(number);
}

//clears any selected text
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

//takes a dom element and checks if it has scrolling content
hasScroll = function(el){

  var domEl = $(el)[0];

  if(domEl.scrollHeight > domEl.clientHeight){

    return true;
  
  }
  
  return false;
}

//checks if the level pages container is scrolling, and adds a scrolling class if it is
pageScrollCheck = function(){

  if(hasScroll('.level-page.active')){
    
    if(!$('#level-pages').hasClass("scrolling")){
     
      return $('#level-pages').addClass('scrolling');
    
    }
  
  } else if($('#level-pages').hasClass("scrolling")){
   
      return $('#level-pages').removeClass('scrolling');
  }
}

//Uses jquery-readyselector functionality to scope the javascript to the levels controller
$("body.levels").ready(function() {
  
    //bind click events for the schema tabs
    $('li.tab').on("click", function(e){

      var $target = $(this);

      if($target.hasClass('active')){
        
        return $target.removeClass('active');
      
      } else{
      
        $("li.tab.active").removeClass('active');

        return $target.addClass('active');
     }
    });
  
  //bind submitQuery function to the execute button of the REPL
  $('#execute').on("click",function(){
      
      var text = $('#sql-command').val();
      
      submitQuery(text);
    
    });

  //bind keyboard shortcuts for the excute button of the REPL
  Mousetrap.bindGlobal(['ctrl+enter','command+return'], function(e){
    e.preventDefault();
    $('#execute').click();
  });

  //bind click events for level pages navigation
  $('#pages-nav .arrow').on("click", function(e){
    e.preventDefault();
    //called to clear text selection in the left pane of the REPL in the event of a double click
    //on one of the arrows
    clearSelection();

    var target = $(e.target);

    if (target.hasClass('arrow')){
      
      swapPage(target);

    }

  });

  //binds checking for level-page scrolling to window resize
  $(window).on('resize', pageScrollCheck);
  
  
})