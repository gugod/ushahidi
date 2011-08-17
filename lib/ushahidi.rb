require "doodle"

module Ushahidi
  class Incident < Doodle
    has :title, :kind => String
    has :description, :kind => String
    has :categories, :init => []
    has :at, :kind => Time

    def to_a
      return [
        "incident_title", title,
        "incident_description", description,
        "incident_date", "%02d/%02d/%04d" % [ at.month, at.mday, at.year ],
        "incident_hour", "%02d" % [at.hour % 12],
        "incident_minute", "%02d" % at.min,
        "incident_ampm", at.hour > 12 ? "pm" : "am",
        "incident_category", categories.join(",")
      ]
    end
  end
    
  class Report < Doodle
    has :location_name, :kind => String
    has :longitude, :kind => Float
    has :latitude, :kind => Float
    
    def to_a
      return [
        "longitude", longitude.to_s,
        "latitude", latitude.to_s,
        "location_name", location_name
      ]
    end

    def post
    end
  end
end
