require 'bigbluebutton_api'

class PagesController < ApplicationController
  def home
    intialize_api_connection

    @current_rooms_created = @api.get_meetings

    @current_recordings = @api.get_recordings
  end

  def create_and_join_meeting
    intialize_api_connection

    record = false

    record = true if request.params[:record]

    create_room(request.params[:room_id], record)

    join_room(request.params[:name], request.params[:password])
  end

  def intialize_api_connection
    url = (ENV['BIGBLUEBUTTON_ENDPOINT'] || 'http://test-install.blindsidenetworks.com/bigbluebutton/') + 'api'
    secret = ENV['BIGBLUEBUTTON_SECRET'] || '8cd8ef52e8e101574e400365b55e11a6'
    version = 0.81

    @api = BigBlueButton::BigBlueButtonApi.new(url, secret, version.to_s, true)
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

    if @api.is_meeting_running?(@meeting_id)
      puts 'Meeting already running'
    else
      response = @api.create_meeting(@meeting_name, @meeting_id, @options)
      puts 'The meeting has been created'
    end
  end

  def join_room(username, password)
    url = @api.join_meeting_url(@meeting_id, username, password)
    redirect_to url.to_s
  end
end
