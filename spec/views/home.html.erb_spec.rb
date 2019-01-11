require 'rails_helper'

describe 'pages/home.html.erb' do
  it 'displays recordings correctly' do
    meeting_inprogress_id = 'test-meeting-display'
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
            url: download_url
          }
        }
      ]
    }

    mock_meeting = { meetings: [] }

    assign(:current_rooms_created, mock_meeting)
    assign(:current_recordings, mock_recording)

    render

    expect(rendered).to include(meeting_id + ' (' + start_time + ')')
  end

  it 'displays opened rooms correctly' do
    meeting_inprogress_id = 'test-meeting-display'

    mock_recording = { recordings: [] }

    mock_meeting = {
      meetings: [
        meetingID: meeting_inprogress_id
      ]
    }

    assign(:current_rooms_created, mock_meeting)
    assign(:current_recordings, mock_recording)

    render

    expect(rendered).to include(meeting_inprogress_id)
  end
end
