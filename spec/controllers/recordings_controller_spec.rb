require 'rails_helper'
require 'bigbluebutton_api'

describe RecordingsController, type: :controller do
  describe 'Recording Controller Tests' do
    it 'gets recordings' do
      expect(controller.get_recordings[:returncode]).to be true
    end

    it 'deletes recordings' do
      first_recording_id = rec_con.get_recordings[:recordings][0][:recordID]

      expect(controller.delete_recording(first_recording_id)[:deleted]).to eq('true')
    end
  end
end
