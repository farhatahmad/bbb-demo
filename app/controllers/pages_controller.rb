require 'bigbluebutton_api'

class PagesController < ApplicationController
  def home

  end

  def create_and_join_meeting
    prepare()

    create()

    join(request.params[:name])
  end

  def prepare
    url = "http://10.8.186.201/bigbluebutton/api"
    secret = "eae6b20cd43c742e3f89b49eebfeeaf1"
    version = 0.81

    @api = BigBlueButton::BigBlueButtonApi.new(url,secret,version.to_s, true)
  end

  def create
    @meeting_name = "Test Meeting 1"
    @meeting_id = "test-meeting-1"
    @options = {
       :moderatorPW => "mp",
       :attendeePW => "ap",
     }

    unless @api.is_meeting_running?(@meeting_id)
      response = @api.create_meeting(@meeting_name, @meeting_id, @options)
      puts "The meeting has been created with the response:"
      puts response.inspect
    else
      puts "Meeting already running"
    end
  end

  def join(username)
    url = @api.join_meeting_url(@meeting_id, username, @options[:moderatorPW])
    puts "1) Moderator URL = #{url}"
  end

end
