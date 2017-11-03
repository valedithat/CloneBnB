class TripsController < ApplicationController
  def index
    @trips = current_user.reservations
  end

  def show
    @reservation = Reservation.find(reservation_id_param)
    render file: "public/404" if current_user != @reservation.user
  end

  private

  def reservation_id_param
    params.require(:reservation).permit(:id)
  end
end
