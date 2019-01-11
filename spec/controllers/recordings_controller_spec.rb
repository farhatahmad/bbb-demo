require 'rails_helper'
require 'bigbluebutton_api'

describe RecordingsController, type: :controller do
  describe 'Recording Controller Tests' do
    let(:rec_con) { RecordingsController.new }
    it 'gets recordings' do
      expect(rec_con.get_recordings[:returncode]).to be true
    end

    it 'deletes recordings' do
      first_recording_id = rec_con.get_recordings[:recordings][0][:recordID]

      expect(rec_con.delete_recording(first_recording_id)[:deleted]).to eq('true')
    end
  end
end
