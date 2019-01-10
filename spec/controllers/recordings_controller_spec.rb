require "rails_helper"

describe RecordingsController, type: :controller do
  let(:rec_con) { RecordingsController.new }


  it "gets recordings" do
    expect(rec_con.get_recordings[:returncode]).to eq(true)
  end

  it "deletes recordings" do
    
  end


end
