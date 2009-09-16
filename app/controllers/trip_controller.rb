class TripController < ApplicationController
  layout "default"

  def index
    @trips = Trip.all(:order => :created_at)
  end

  def show
    @trip = Trip.find_by_id(params[:id])
    @pings = @trip.pings.all(:order => :when_timestamp)

    @map = GMap.new("map")
    @map.control_init(:large_map => true, :map_type => true)

    # Create our initial point
    marker = GMarker.new([@pings.first.latitude, @pings.first.longitude],
                         :title => @pings.first.when_timestamp.to_s,
                         :info_window => @pings.first.message)
    @map.overlay_init(marker)

    @map.center_zoom_init([@pings.first.latitude, @pings.first.longitude], 4)
    @gmap_header = GMap.header
  end
end
