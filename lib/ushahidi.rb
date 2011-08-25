
require "doodle"
require "rest-client"
require "json"

class Ushahidi
  class Incident < Doodle
    has :title, :kind => String
    has :description, :kind => String
    has :categories, :init => []
    has :at, :kind => Time
    has :photos, :init => []
    has :news, :init => ""

    def to_params_hash
      return {
        "incident_title"       => title,
        "incident_description" => description,
        "incident_date"        => "%02d/%02d/%04d" % [ at.month, at.mday, at.year ],
        "incident_hour"        => "%02d" % [ at.hour % 12 ],
        "incident_minute"      => "%02d" % [ at.min ],
        "incident_ampm"        => at.hour > 12 ? "pm" : "am",
        "incident_category"    => categories.join(",")
      }
    end
  end
    
  class Report < Doodle
    has :incident, :kind => Incident
    has :location_name, :kind => String
    has :longitude, :kind => Float
    has :latitude, :kind => Float
    
    def to_params_hash
      incident.to_params_hash.merge(
        "location_name" => "#{location_name}",
        "longitude"     => "#{longitude}",
        "latitude"      => "#{latitude}"
        )
    end

    def self.approve(id)
      raise "No api base" unless Ushahidi.api_base

      res = RestClient.post(Ushahidi.api_base, {
          :task => "reports",
          :incident_id => id.to_s,
          :action => "approve"
        })
      return JSON.parse(res)
    end
  end

  @@api_base = nil

  def self.api_base
    @@api_base
  end

  def self.api_base=(x)
    @@api_base = x
  end

  def self.post(x)
    raise "No api base" unless @@api_base
    raise "Can only post report" unless x.is_a? Report

    h = x.to_params_hash

    h["task"] = "report"

    RestClient.post(@@api_base, h)
  end

  def self.unapproved_report_ids
    raise "No api base" unless @@api_base

    res = RestClient.post(@@api_base, {
        :task => "reports",
        :by => "unapproved"
      })

    r = JSON.parse(res)

    return r["payload"]["incidents"].map { |x| x["incident"]["incidentid"].to_i }
  end
end
