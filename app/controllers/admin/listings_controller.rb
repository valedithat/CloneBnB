class Admin::ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def destroy
    listing = Listing.find(params[:id])
    listing.images.delete
    listing.reservations.delete
    listing.delete
    flash[:notice] = "#{listing.id} successfully deleted"
    redirect_to admin_listings_path
  end

  # private
  #
  # def listing_params
  #   params.require(:listing).permit(:id)
  # end
end
