require 'bigbluebutton_api'

class PagesController < ApplicationController
  include InitializeHelper

  def initialize
    super
    @@api = initialize_api
    @@recording_controller = RecordingsController.new
  end

  def home
    @current_rooms_created = @@api.get_meetings

    @current_recordings = @@recording_controller.get_recordings
  end

  def create_and_join_meeting
    record = false

    record = true if request.params[:record]

    create_room(request.params[:room_id], record)

    join_room(request.params[:name], request.params[:password])
  end

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

  def join_room(username, password)
    url = @@api.join_meeting_url(@meeting_id, username, password)
    redirect_to url.to_s
  end
end
