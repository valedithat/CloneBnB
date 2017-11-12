class TripsController < ApplicationController
  def index
    @trips = current_user.reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
    render file: "public/404" if current_user != @reservation.user
  end
  #
  # private
  #
  # def reservation_id_param
  #   params.require(:reservation).permit(:id)
  # end
end
