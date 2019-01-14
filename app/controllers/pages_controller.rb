require 'bigbluebutton_api'

class PagesController < ApplicationController
  include InitializeHelper #uses the InitializeHelper module

  #initializes the api and creates an instance of the recording class
  def initialize
    super
    @@api = initialize_api  #calls the function in the InitializeHelper module
    @@recording_controller = RecordingsController.new
  end

  #function that runs on "/" page load
  def home
    @current_rooms_created = @@api.get_meetings
    @current_recordings = @@recording_controller.get_recordings
  end

  #function that first creates the meeting and then joins the user to the meeting
  #using the values set in the POST response
  def create_and_join_meeting
    record = if request.params[:record] then true else false

    create_room(request.params[:room_id], record)

    join_room(request.params[:name], request.params[:password])
  end

  #creates a room in Big Blue Button
  def create_room(room_id = 'default-room-id', record = false)
    @meeting_name = room_id.tr('-', ' ').titleize
    @meeting_id = room_id
    @options = {
      moderatorPW: ENV['DEMO_MP'] || 'mp',
      attendeePW: ENV['DEMO_AP'] || 'ap',
      record: record.to_s,
      autoStartRecording: record.to_s,
      logoutURL: root_url
    }

    if @@api.is_meeting_running?(@meeting_id)
      puts 'Meeting already running'
    else
      response = @@api.create_meeting(@meeting_name, @meeting_id, @options)
      puts 'The meeting has been created'
    end
  end

  #adds the user to the specified room with the specified privileges
  def join_room(username, password, id = "")
    if id == ""
      meeting_room = @meeting_id
    else
      meeting_room = id
    end

    url = @@api.join_meeting_url(meeting_room, username, password)
    redirect_to url.to_s
  end
end
