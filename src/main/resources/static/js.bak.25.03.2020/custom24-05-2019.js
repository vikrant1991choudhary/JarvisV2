//predictive hide, show
$("#predGraph").click(function(){
  $("#container").hide();
  $("#containerB").show();
  $("#backBtn").show();
  $("#predGraph").hide();
});
$("#backBtn").click(function(){
  $("#containerB").hide();
  $("#container").show();
  $("#backBtn").hide();
  $("#predGraph").show();
});

// range slider
$( function() {
    $( "#slider-range" ).slider({
      range: true,
      min: 0,
      max: 100,
      values: [ 1, 90 ],
      slide: function( event, ui ) {
        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
      $("#minIncome").val(ui.values[ 0 ]);
      $("#maxIncome").val(ui.values[ 1 ]);
      }
    });
    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
      " - $" + $( "#slider-range" ).slider( "values", 1 ) );
      
  } );

  $( function() {
    $( "#slider-rangeB" ).slider({
      range: true,
      min: 0,
      max: 80,
      values: [ 0, 80 ],
      slide: function( event, ui ) {
        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
         $("#minb").val(ui.values[ 0 ]);
      $("#maxb").val(ui.values[ 1 ]);
      }
    });
    $( "#amount" ).val( "$" + $( "#slider-rangeB" ).slider( "values", 0 ) +
      " - $" + $( "#slider-rangeB" ).slider( "values", 1 ) );
      
     
      
  } );
  $( function() {
    $( "#slider-rangeC" ).slider({
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

  

filterModal_expanded_checkbox = null;
//multi select
function showCheckboxes(checkBoxElement) {
  
  var checkboxes = $('#' + checkBoxElement);

  if (checkboxes.is(':visible')) {
    checkboxes.hide();
    filterModal_expanded_checkbox = null;
  } else {
    if (filterModal_expanded_checkbox) {
      filterModal_expanded_checkbox.hide();
    }
    checkboxes.show();
    filterModal_expanded_checkbox = checkboxes;
  }
}


$(document).ready(function(){
    // multi select dropdown with search
  $("#langOptgroup").multiselect({
      columns: 1,
      placeholder: 'Select Year',
      search: true,
      selectAll: true
    });

// closing dropdowns when clicked outside of dropdowns
  $("#filter").on("click", function(evt) {

    // Stop event from bubbling up.
    evt.stopPropagation();

    // When clicking in the filter modal.
    element = $(evt.target);

    if (!(element.hasClass('overSelect') || element.hasClass('selectBox'))) {
      
      const thisTagname = element.get(0).tagName;
      const parentTagname = element.parent().get(0).tagName;

      if (
        (thisTagname === 'LABEL' && !element.hasClass('customLabel')) ||
        (parentTagname === 'LABEL' && !element.parent().hasClass('customLabel')) ||
        (thisTagname !== 'LABEL' && parentTagname !== 'LABEL')
      ) {
        if (filterModal_expanded_checkbox) {
          filterModal_expanded_checkbox.hide();
        }
      }
    }
    
  })
  
  
  /* $("#checkAll, #checkAll2, #checkAll3, #checkAll4").click(function () {
    $('input:checkbox').not(this).prop('checked', this.checked);
  }); */
  
  $("#checkboxes1, #checkboxes2, #checkboxes3, #checkboxes4").on('click', 'label', function (evt) {
    // stop event bubbling
    evt.stopPropagation();

    const clickedElement = $(this);

    const elementText = clickedElement.text().replace(/\s/g, '').toLowerCase();
    const childSelected = clickedElement.find('input').prop('checked');
    
    if (elementText === 'all') {
      clickedElement.parent().find('input').prop('checked', childSelected);
    } else {
      if (!childSelected) {
        const firstInputBox = clickedElement.parent().find('input[type="checkbox"]').get(0);
        $(firstInputBox).prop('checked', false);
      }
    }
    
  });
    
  
  //hide and show/ tabuler view

  $( "#tabu-btn" ).click(function() {
    $( ".tabu-table" ).fadeToggle( "slow", "linear" );
  });

  $("#tabu-btn").click(function(){
    $(this).text($(this).text() == 'VIEW TABULAR INFORMATION' ? 'GO BACK TO GRAPH' : 'VIEW TABULAR INFORMATION');
  });

});

		
//Gallery		
let modalId = $('#image-gallery');		
$(document)		
  .ready(function () {		
    loadGallery(true, 'a.thumbnail');		
    //This function disables buttons when needed		
    function disableButtons(counter_max, counter_current) {		
      $('#show-previous-image, #show-next-image')		
        .show();		
      if (counter_max === counter_current) {		
        $('#show-next-image')		
          .hide();		
      } else if (counter_current === 1) {		
        $('#show-previous-image')		
          .hide();		
      }		
    }		
    function loadGallery(setIDs, setClickAttr) {		
      let current_image,		
        selector,		
        counter = 0;		
      $('#show-next-image, #show-previous-image')		
        .click(function () {		
          if ($(this)		
            .attr('id') === 'show-previous-image') {		
            current_image--;		
          } else {		
            current_image++;		
          }		
          selector = $('[data-image-id="' + current_image + '"]');		
          updateGallery(selector);		
        });		
      function updateGallery(selector) {		
        let $sel = selector;		
        current_image = $sel.data('image-id');		
        $('#image-gallery-title')		
          .text($sel.data('title'));		
        $('#image-gallery-image')		
          .attr('src', $sel.data('image'));		
        disableButtons(counter, $sel.data('image-id'));		
      }		
      if (setIDs == true) {		
        $('[data-image-id]')		
          .each(function () {		
            counter++;		
            $(this)		
              .attr('data-image-id', counter);		
          });		
      }		
      $(setClickAttr)		
        .on('click', function () {		
          updateGallery($(this));		
        });		
    }		
  });		
// build key actions		
$(document)		
  .keydown(function (e) {		
    switch (e.which) {		
      case 37: // left		
        if ((modalId.data('bs.modal') || {})._isShown && $('#show-previous-image').is(":visible")) {		
          $('#show-previous-image')		
            .click();		
        }		
        break;		
      case 39: // right		
        if ((modalId.data('bs.modal') || {})._isShown && $('#show-next-image').is(":visible")) {		
          $('#show-next-image')		
            .click();		
        }		
        break;		
      default:		
        return; // exit this handler for other keys		
    }		
    e.preventDefault(); // prevent the default action (scroll / move caret)		
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

// Image download
var node = document.getElementById('my-node');
var btn = document.getElementById('downImg');
btn.onclick = function() {
  domtoimage.toBlob(document.getElementById('my-node'))
    .then(function(blob) {
      window.saveAs(blob, 'my-node.png');
    });
}
//tab
function openCity(evt, cityName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
}