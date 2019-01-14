// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function deleteRecording(iconClicked){
  var recordID = $(iconClicked).data('id')

  $.post("/deleteRecording", {recordID}, function(){
    location.reload() //reload the page once the delete has completed
  })
}

function joinRoom(iconClicked) {
  var meetingID = $(iconClicked).data('id')

  $("#room_id").val(meetingID)   //autofill the Meeting ID box

  //style the Meeting ID box for 2 seconds
  $("#room_id").css("box-shadow","0px 0px 5px green")
  setTimeout(function() {   $("#room_id").css("box-shadow","") }, 2000);
}

function playRecording(iconClicked) {
  var url = $(iconClicked).data('url')

  //open the url in a new tab and switch to said tab
  var win = window.open(url, '_blank');
  win.focus();
}
