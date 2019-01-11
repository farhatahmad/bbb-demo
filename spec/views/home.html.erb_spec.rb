require 'rails_helper'

describe 'pages/home.html.erb' do
  it 'displays recordings correctly' do

    meeting_id = 'test-room-recording'
    start_time = '2010-01-10T17:37:55-05:00'
    record_id = 'test-record-id'
    download_url = 'http://youtube.com'

    mock_recording = {
      recordings: [
        meetingID: meeting_id,
        startTime: start_time,
        recordID: record_id,
        playback: {
          format: {
            url: download_url,
          },
        },
      ],
    }

    assign(:current_rooms_created, {meetings: [ ]})
    assign(:current_recordings, mock_recording)

    render

    expect(rendered).to include(meeting_id.to_s + " (" + start_time.to_s + ")")

  end
end
