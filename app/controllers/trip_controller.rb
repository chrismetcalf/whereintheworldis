class TripController < ApplicationController
  layout "default"

  def index
  end

  def show
    @trip = Trip.find_by_id(params[:id])
    @pings = @trip.pings

    @map = GMap.new("map")
    @map.control_init(:large_map => true, :map_type => true)

    # Create our initial point
    marker = GMarker.new([@pings.first.latitude, @pings.first.longitude],
                         :title => @pings.first.when.to_s,
                         :info_window => @pings.first.message)
    @map.overlay_init(marker)

    @map.center_zoom_init([@pings.first.latitude, @pings.first.longitude], 4)
  end
end
