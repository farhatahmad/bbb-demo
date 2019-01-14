require 'rails_helper'
require 'bigbluebutton_api'

describe RecordingsController, type: :controller do
  describe 'Recording Controller Tests' do
    it 'gets recordings' do
      expect(controller.get_recordings[:returncode]).to be true
    end

    it 'deletes recordings' do
      recordings = controller.get_recordings[:recordings]
      if recordings.length > 0
        first_recording_id = recordings[0][:recordID]
        expect(controller.delete_recording(first_recording_id)[:deleted]).to eq('true')
      else
        puts 'no recordings to delete. Unable to test'
      end
    end
  end
end
