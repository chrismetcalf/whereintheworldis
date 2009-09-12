require 'tmail'

module PingHelper
  #####################################
  # Utility Functions
  #####################################

  # Returns a Lat, Long array from a string
  def parse_lat_long(raw)
    m = raw.match(/(\d+\.?\d*)\s*([NS])\s+(\d+\.?\d*)\s*([WE])/i)
    if m.nil? || m.size != 5
      return nil
    else
      latitude = m[1].to_f * (m[2] =~ /N/i ? 1.0 : -1.0)
      longitude = m[3].to_f * (m[4] =~ /W/i ? 1.0 : -1.0)

      return [latitude, longitude]
    end
  end

  def parse_message(message)
    # Use TMail to pick apart the actual message
    mail = TMail::Mail.parse message.pop

    # Extract the latitude and longitude
    lat, long = parse_lat_long mail.subject

    # Extract the message
    body = ""
    if mail.multipart?
      # Multipart, try to find the text version
      mail.parts.each do |part|
        puts "Type: #{part.main_type}"
        if part.main_type =~ /text/i
          body = part.body
        end
      end
    else
      # Non-multipart, take the whole body
      body = mail.body
    end

    # Fill out our object to return
    ping = Ping.new
    ping.when = mail.date
    ping.latitude = lat
    ping.longitude = long
    ping.message = body.strip

    return ping
  end
end
