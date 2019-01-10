// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function deleteRecording(iconClicked){
  var recordID = $(iconClicked).data('id')

  $.post("/deleteRecording", {recordID}, function(){
    location.reload()
  })
}

function joinRoom(iconClicked) {
  var meetingID = $(iconClicked).data('id')
  $("#room_id").val(meetingID)
  $("#room_id").css("box-shadow","0px 0px 5px green")
}

function playRecording(iconClicked) {
  var url = $(iconClicked).data('url')
  var win = window.open(url, '_blank');
  win.focus();
}
