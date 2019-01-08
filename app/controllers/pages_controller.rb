require 'bigbluebutton_api'

class PagesController < ApplicationController
  def home; end

  def create_and_join_meeting
    prepare

    create

    join(request.params[:name])
  end

  def prepare
    url = 'http://10.8.186.201/bigbluebutton/api'
    secret = 'eae6b20cd43c742e3f89b49eebfeeaf1'
    version = 0.81

    @api = BigBlueButton::BigBlueButtonApi.new(url, secret, version.to_s, true)
  end

  def create
    @meeting_name = 'Demo Meeting'
    @meeting_id = 'demo-meeting'
    @options = {
      moderatorPW: 'mp',
      attendeePW: 'ap'
    }

    if @api.is_meeting_running?(@meeting_id)
      puts 'Meeting already running'
    else
      response = @api.create_meeting(@meeting_name, @meeting_id, @options)
      puts 'The meeting has been created'
    end
  end

  def join(username)
    url = @api.join_meeting_url(@meeting_id, username, @options[:moderatorPW])
    redirect_to url.to_s
  end
end
