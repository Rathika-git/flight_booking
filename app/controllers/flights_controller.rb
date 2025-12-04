class FlightsController < ApplicationController
  def index
    @airports = Airport.all
    @dates = Flight.order(:start_datetime).pluck(:start_datetime).map(&:to_date).uniq

    if params[:flight].present? && params[:commit] == "Search"
      if search_params_blank?
        flash.now[:alert] = "Please select all search fields before searching"
      else
        handle_search
      end
    end

    handle_selection if params[:commit] == "Select Flight"
  end

  private

  def search_params_blank?
    params[:flight][:departure_airport_id].blank? ||
      params[:flight][:arrival_airport_id].blank? ||
      params[:flight][:date].blank? ||
      params[:flight][:passengers].blank?
  end

  def handle_search
    @selected_departure = params[:flight][:departure_airport_id]
    @selected_arrival   = params[:flight][:arrival_airport_id]
    @selected_date      = params[:flight][:date]
    @selected_passengers = params[:flight][:passengers]

    date = Date.parse(@selected_date) rescue nil
    if date
      @flights = Flight.where(
        departure_airport_id: @selected_departure,
        arrival_airport_id: @selected_arrival
      ).where(start_datetime: date.beginning_of_day..date.end_of_day)
    else
      @flights = Flight.none
    end
  end

 def handle_selection
  if params[:commit] == "Select Flight"
    if params[:flight_id].blank?
      flash.now[:flight_error] = "Please select a flight"
      handle_search if params[:flight].present?
    else
      redirect_to new_booking_path(
        flight_id: params[:flight_id],
        passengers: params[:passengers]
      ) and return
    end
  end
end
end
