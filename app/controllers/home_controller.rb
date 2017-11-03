class HomeController < ApplicationController
  def index
    @listings = Listing.select(:city).distinct.order('city ASC')
    @most_popular_listings = Listing.most_visits_all(limit: 4) #fix and sanitize?
  end

  def show
    @city = params[:format]
    @listings_by_city = Listing.list_by_city(params[:format]) #fix and sanitize?
  end
end
