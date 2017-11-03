class Listings::ReviewsController < ApplicationController
  def new
  end

  def create
    listing = Listing.find(listing_params)
    review  = listing.reviews.new(review_params)
    if review.save
      redirect_to listing_path(listing)
      flash[:sucess] = "You have successfully submitted a review!"
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :stars, :message)
  end

  def listing_params
    params.require(:listing).permit(:listing_id)
  end
end
