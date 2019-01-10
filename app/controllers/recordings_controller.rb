class RecordingsController < ApplicationController
  include InitializeHelper

  def initialize
    super
    @@api = initialize_api
  end

  def delete_recording
    id = request.params[:recordID]
    @@api.delete_recordings(id)
  end

  def get_recordings
    @@api.get_recordings
  end
end
