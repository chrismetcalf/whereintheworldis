require 'net/pop'
require 'tmail'

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
            ping = TMail::Mail.parse m.pop

            logger.debug "Subject: #{mail.subject}"
            # Check to see if it matches our expected format
            lat, long = parse_lat_long mail.subject

            if lat.nil? || long.nil?
              logger.info "Message subject didn't match expected pattern: #{mail.subject}"
              next
            end

            # We've found a new ping
            ping = Ping.new

            # TODO Handle message
            # m.delete
          end
        end
      end
    end
  end
end
