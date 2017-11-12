class ReservationsController < ApplicationController
  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = @listing.reservations.new(reservation_params)
    @reservation.user = current_user
    if @reservation.no_overlapping? && @reservation.save
      flash[:success] = "Successfully made reservation"
      redirect_to reservation_path(@reservation)
    else
      flash[:error] = "Reservation not created. Please select another date range."
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def index
    user = User.find(params[:user_id])
    @listings = user.listings
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update!(status: params[:status]) #sanitize??
      flash[:success] = "reservation #{@reservation.id} updated to #{@reservation.status}"
      redirect_to user_reservations_path(current_user)
    else
      flash[:error] = "Reservation not updated"
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :status)
  end

  # def reservation_id_param
  #   params.require(:reservation).permit(:id)
  # end

  # def user_id_param
  #   params.requrire(:user).permit(:user_id)
  # end

  # def listing_params
  #   params.require(:listing).permit(:listing_id)
  # end
end
