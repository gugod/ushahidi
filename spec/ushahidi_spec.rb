require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# API Ref: http://wiki.ushahidi.com/doku.php?id=ushahidi_api

describe "Ushahidi" do
end

describe "Ushahidi::Incident" do
  it "has all the required fields" do
    # incident_title - Required. The title of the incident/report.
    # incident_description - Required. The description of the incident/report.
    # incident_date - Required. The date of the incident/report. It usually in the format mm/dd/yyyy.
    # incident_hour - Required. The hour of the incident/report. In the 12 hour format.
    # incident_minute - Required. The minute of the incident/report.
    # incident_ampm - Required. Is the incident/report am or pm. It of the form, am or pm.
    # incident_category - Required. The categories the incident/report belongs to. It should be a comma separated value csv

    x = Ushahidi::Incident.new(
      :title => "XyZ",
      :description => "Xyz Xyz Xyz",
      :at => Time.utc(2000,5,5,10,5,0),
      :categories => [1,2,3,5]
      )

    x.to_a.should == [
      "incident_title", "XyZ",
      "incident_description", "Xyz Xyz Xyz",
      "incident_date", "05/05/2000",
      "incident_hour", "10",
      "incident_minute", "05",
      "incident_ampm", "am",
      "incident_category", "1,2,3,5"
    ]
  end
end

describe "Ushahidi::Report" do
  before do
    @report = Ushahidi::Report.new(
      :longitude => 23.45,
      :latitude => 123.45,
      :location_name => "Somewhere Center"
      )
  end

  it "can be posted" do
    @report.respond_to?(:post).should be_true
  end

  it "has those attribute accessors" do
    @report.to_a.should == [
      "longitude", "23.45",
      "latitude", "123.45",
      "location_name", "Somewhere Center"
    ]
  end
end
