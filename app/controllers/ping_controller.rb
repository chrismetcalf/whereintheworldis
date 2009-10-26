require 'net/pop'

class PingController < ApplicationController

  def index
    puts "hello world"
  end

  def update
    # TODO Add verify line, POST only

    Traveller.find(:all).each do |traveller|
      # Poll for each traveler's updates
      Net::POP3.start(traveller.pop_host, 110,
                      traveller.pop_login,
                      traveller.pop_password) do |pop|
        if pop.mails.empty?
          logger.debug "No mail for #{traveller.name}"
        else
          @mails = Array.new
          # Process mails

          pop.mails.each do |m|
            # Parse this mail
            ping = parse_message m

            # TODO Handle message
            # m.delete
          end
        end
      end
    end
  end

  protected 
    #####################################
    # Utility Functions
    #####################################

    # Returns a Lat, Long array from a string
    def parse_lat_long(raw)
      m = raw.match(/(\d+)\s+(\d+\.?\d*)\s*([NS])\s+(\d+)\s+(\d+\.?\d*)\s*([WE])/i)
      if m.nil? || m.size != 5
        return nil
      else
        # Parse out degrees and minutes
        latitude = m[1].to_f + (m[2].to_f / 60.0)
        longitude = m[4].to_f + (m[5].to_f / 60.0)

        # Figure out negative vs positive
        latitude *= (m[3] =~ /N/i ? 1 : -1)
        longitude += (m[6] =~ /E/i ? 1 : -1)

        return [latitude, longitude]
      end
    end

    def parse_message(message)
      # Use TMail to pick apart the actual message
      mail = TMail::Mail.parse message.pop

      # Extract the latitude and longitude
      lat, long = parse_lat_long mail.subject

      if lat.nil? || long.nil?
        return nil
      end

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
      ping.when_timestamp = mail.date
      ping.latitude = lat
      ping.longitude = long
      ping.message = body.strip

      return ping
    end
end
