class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def destroy
    review = Review.find(params[:id])
    review.delete
    flash[:notice] = "#{review.id} successfully deleted"
    redirect_to admin_reviews_path
  end

  # private
  #
  # def review_id_params
  #   params.require(:review).permit(:id)
  # end
end
