// range slider
$( function() {
    $( "#slider-range" ).slider({
      range: true,
      min: 0,
      max: 500,
      values: [ 75, 300 ],
      slide: function( event, ui ) {
        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
      }
    });
    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
      " - $" + $( "#slider-range" ).slider( "values", 1 ) );
  } );

  $( function() {
    $( "#slider-rangeB" ).slider({
      range: true,
      min: 0,
      max: 500,
      values: [ 75, 300 ],
      slide: function( event, ui ) {
        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
      }
    });
    $( "#amount" ).val( "$" + $( "#slider-rangeB" ).slider( "values", 0 ) +
      " - $" + $( "#slider-rangeB" ).slider( "values", 1 ) );
  } );

  

var expanded_checkbox = null;
//multi select
function showCheckboxes(checkBoxElement) {
  
  var checkboxes = $('#' + checkBoxElement);

  if (checkboxes.is(':visible')) {
    checkboxes.hide();
    expanded_checkbox = null;
  } else {
    if (expanded_checkbox) {
      expanded_checkbox.hide();
    }
    checkboxes.show();
    expanded_checkbox = checkboxes;
  }
}


$(document).ready(function(){
  
  $("#checkAll, #checkAll2, #checkAll3, #checkAll4").click(function () {
    $('input:checkbox').not(this).prop('checked', this.checked);
  });
  
  //hide and show/ tabuler view

  $( "#tabu-btn" ).click(function() {
    $( ".tabu-table" ).fadeToggle( "slow", "linear" );
  });

  $("#tabu-btn").click(function(){
    $(this).text($(this).text() == 'VIEW TABULAR INFORMATION' ? 'GO BACK TO GRAPH' : 'VIEW TABULAR INFORMATION');
  });

});


//table content download as pdf

function demoFromHTML() {
  var pdf = new jsPDF('p', 'pt', 'letter');
  // source can be HTML-formatted string, or a reference
  // to an actual DOM element from which the text will be scraped.
  source = $('#customers')[0];

  // we support special element handlers. Register them with jQuery-style 
  // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
  // There is no support for any other type of selectors 
  // (class, of compound) at this time.
  specialElementHandlers = {
      // element with id of "bypass" - jQuery style selector
      '#bypassme': function (element, renderer) {
          // true = "handled elsewhere, bypass text extraction"
          return true
      }
  };
  margins = {
      top: 80,
      bottom: 60,
      left: 40,
      width: 522
  };
  // all coords and widths are in jsPDF instance's declared units
  // 'inches' in this case
  pdf.fromHTML(
  source, // HTML string or DOM elem ref.
  margins.left, // x coord
  margins.top, { // y coord
      'width': margins.width, // max width of content on PDF
      'elementHandlers': specialElementHandlers
  },

  function (dispose) {
      // dispose: object with X, Y of the last line add to the PDF 
      //          this allow the insertion of new lines after html
      pdf.save('Test.pdf');
  }, margins);
}

