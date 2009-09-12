class TravellerController < ApplicationController
  def index
    @travellers = Traveller.find(:all)
  end

  def show
    @traveller = Traveller.find_by_id(params[:id])
    @trips = @traveller.trips.find(:all)
  end
end
