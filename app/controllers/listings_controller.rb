class ListingsController < ApplicationController
  def index
    @listings = Listing.page(params[:page]) #fix and sanitize?
  end

  def show
    @listing = Listing.find(listing_id_param)
    @reservation_listing = @listing.user_stayed_at?(current_user)
    render file: "public/404" unless @listing.user.status == "active"
  end

  private

  def listing_id_param
    params.require(:listing).permit(:id)
  end
end
