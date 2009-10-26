class TripController < ApplicationController
  layout "default"

  def index
    @trips = Trip.all(:order => :created_at)
  end

  def show
    @trip = Trip.find_by_id(params[:id])
    @title = @trip.name

    @pings = @trip.pings.all(:order => "when_timestamp ASC")

    @map = GMap.new("map")
    @map.control_init(:large_map => true, :map_type => true)

    # Create our initial point
    @latest = @pings.first
    marker = GMarker.new([@latest.latitude, @latest.longitude],
                         :title => @latest.when_timestamp.to_s,
                         :info_window => "<h3>#{@latest.when_timestamp}:</h3> #{@latest.message}")
    @map.overlay_init(marker)

    # Add the rest of the pings
    @pings.each do |p|
      @map.record_init @map.add_overlay(GMarker.new([p.latitude, p.longitude],
                                                    :title => p.when_timestamp.to_s,
                                                    :info_window => 
                                                      "<h3>#{p.when_timestamp}:</h3> #{p.message}"))
    end

    @map.center_zoom_init([@pings.first.latitude, @pings.first.longitude], 4)
  end
end
